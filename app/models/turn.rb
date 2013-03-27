class Turn < ActiveRecord::Base
  attr_accessible :game_piece_id, :spaces, :turn_number

end
