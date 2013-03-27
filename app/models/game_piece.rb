class GamePiece < ActiveRecord::Base
  attr_accessible :game_id, :image_url, :last_space, :name
  belongs_to :game
end
