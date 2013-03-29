class Bonus < ActiveRecord::Base
  attr_accessible :bonus_type, :description, :player_id, :spaces, :turn_id
  self.table_name = "bonuses"
  belongs_to :turn

   def self.get_bonus_card

   bonus_list = [
      "GU packet"  ,
      "water fountain" ,
      "amazing view",
      "favorite song",
      "found money",
      "ran with a friend",
      "sprinkler run",
      "shady trail",
      "second wind",
      "run to cure hangover",
      "runner's high",
      "dog poo",
      "leg cramp",
      "50mph wind",
      "hit the wall",
      "music died"]  
        
   bonus_list.at(rand(16))
   end

end
