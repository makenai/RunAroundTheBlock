class Player < ActiveRecord::Base
  attr_accessible :game_piece_id, :turn_joined, :user_id
  attr_accessor :answer
  belongs_to :user
  belongs_to :game_piece
end
