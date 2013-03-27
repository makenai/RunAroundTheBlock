class User < ActiveRecord::Base

  def self.from_omniauth(auth)
    raise auth.to_yaml
    where(auth.slice('runkeeper_id')).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.runkeeper_id = auth.uid
      user.name         = auth['info']['name']
      user.nickname     = auth['info']['nickname']
      user.location     = auth['info']['location']
      user.gender       = auth['extra']['raw_info']['gender']
      user.image_url    = auth['extra']['raw_info']['normal_picture']
      user.thumb_url    = auth['extra']['raw_info']['small_picture'] || auth['extra']['raw_info']['medium_picture']
      user.token        = auth['credentials']['token']
    end
  end

  def past_activities
  end
end
