class Bonus < ActiveRecord::Base
  attr_accessible :bonus_type, :description, :player_id, :spaces, :turn_id
  self.table_name = "bonuses"
end
