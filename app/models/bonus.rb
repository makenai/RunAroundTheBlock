class Bonus < ActiveRecord::Base
  attr_accessible :bonus_type, :description, :player_id, :spaces, :turn_id, :mileage
  self.table_name = "bonuses"
  belongs_to :turn

    EVENTS = [
      # Good things
      { description: "You ate a GU packet!", spaces: 1 },
      { description: "You found a water fountain!", spaces: 1 },
      { description: "You discovered an amazing view!", spaces: 1 },
      { description: "Your favorite song came on Pandora!", spaces: 1 },
      { description: "You found some money on the ground!", spaces: 1 },
      { description: "You ran with a friend!", spaces: 1 },
      { description: "You ran through sprinklers!", spaces: 1 },
      { description: "You found a shady trail!", spaces: 1 },
      { description: "You got a second wind!", spaces: 1 },
      { description: "You got a runner's high!", spaces: 1 },

      # Bad things
      { description: "You ran through dog poo!", spaces: -1 },
      { description: "You got a leg cramp!", spaces: -1 },
      { description: "It's really windy!", spaces: -1 },
      { description: "You hit a wall.", spaces: -1 },
      { description: "Your music device died!", spaces: -1 }
    ]  

   def self.get_event
    EVENTS.sample(1).first
   end

end
