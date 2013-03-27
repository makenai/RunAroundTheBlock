class Turn < ActiveRecord::Base
  attr_accessible :gamepiece_id, :spaces, :turn_number
end
