class User < ActiveRecord::Base

  has_many :players
  has_many :game_pieces, through: :players

  METERS_PER_MILE = 1609.34

  def self.from_omniauth(auth)
    user = where(auth.slice('runkeeper_id')).first || create_from_omniauth(auth)
    user.name      = auth['info']['name']
    user.nickname  = auth['info']['nickname']
    user.location  = auth['info']['location']
    user.gender    = auth['extra']['raw_info']['gender']
    user.image_url = auth['extra']['raw_info']['normal_picture']
    user.thumb_url = auth['extra']['raw_info']['small_picture'] || auth['extra']['raw_info']['medium_picture']
    user.token     = auth['credentials']['token']
    user.save
    user
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.runkeeper_id = auth.uid
    end
  end

  def mileage_on(date = Date.yesterday)
    return Random.rand( 7 ) if Game::DEMO_FLAG
    
    date   = DateTime.parse(date.to_s).to_date
    meters = 0

    recent_activities.each do |activity|
      next unless activity['type'] == 'Running'
      next unless DateTime.parse(activity['start_time']).to_date == date
      meters += activity['total_distance']
    end

    meters / METERS_PER_MILE
  end

  def playing_game?
    self.game_pieces.where( game_id: Game.current.id ).first.present?
  end

  private

  def runkeeper
    @runkeeper ||= Runkeeper.new(token)
  end

  def recent_activities
    runkeeper.fitness_activities.parsed_response['items']
  end

end
