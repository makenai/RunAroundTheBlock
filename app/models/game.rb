class Game < ActiveRecord::Base
  attr_accessible :current_turn_number, :ended_at, :start_at, :winner_game_piece_id
end
