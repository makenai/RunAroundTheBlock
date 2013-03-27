class Player < ActiveRecord::Base
  attr_accessible :gamepiece_id, :turn_joined, :user_id
end
