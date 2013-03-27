class User < ActiveRecord::Base

  has_many :players
  has_many :game_pieces, through: :players

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

  def past_activities
  end

  def playing_game?
    self.game_pieces.where( game_id: Game.current.id ).first.present?
  end

end
