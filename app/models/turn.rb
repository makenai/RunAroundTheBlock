class Turn < ActiveRecord::Base
  attr_accessible :game_piece_id, :spaces, :turn_number
  belongs_to :game_piece
  has_many :bonuses
end