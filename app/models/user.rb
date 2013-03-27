class User < ActiveRecord::Base

  METERS_PER_MILE = 1609.34

  def self.from_omniauth(auth)
    user = where(auth.slice('runkeeper_id')).first || create_from_omniauth(auth)
    user.tap do |user|
      user.name      = auth['info']['name']
      user.nickname  = auth['info']['nickname']
      user.location  = auth['info']['location']
      user.gender    = auth['extra']['raw_info']['gender']
      user.image_url = auth['extra']['raw_info']['normal_picture']
      user.thumb_url = auth['extra']['raw_info']['small_picture'] || auth['extra']['raw_info']['medium_picture']
      user.token     = auth['credentials']['token']
      user.save
    end
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.runkeeper_id = auth.uid
    end
  end

  def mileage_on(date = Date.yesterday)
    date   = DateTime.parse(date.to_s).to_date
    meters = 0

    recent_activities.each do |activity|
      next unless activity['type'] == 'Running'
      next unless DateTime.parse(activity['start_time']).to_date == date
      meters += activity['total_distance']
    end

    meters / METERS_PER_MILE
  end

  private

  def runkeeper
    @runkeeper ||= Runkeeper.new(token)
  end

  def recent_activities
    runkeeper.fitness_activities.parsed_response['items']
  end

end
