class Turn < ActiveRecord::Base
  attr_accessible :game_piece_id, :spaces, :turn_number, :starting_space
  belongs_to :game_piece
  has_many :bonuses
  after_create :process_bonuses

  def process_bonuses
    if random_player = self.game_piece.players.sample(1).first
      mileage = random_player.mileage_on
      if mileage > self.spaces
        self.bonuses << Bonus.create(
          :bonus_type  => 'wheel_of_fate',
          :description => 'You beat the odds!', 
          :player_id   => random_player.id,
          :spaces      => 1,
          :mileage     => mileage
        )
      else
        self.bonuses << Bonus.create(
          :bonus_type  => 'wheel_of_fate',
          :description => 'Boo!', 
          :player_id   => random_player.id,
          :spaces      => 0,
          :mileage     => mileage
        )
      end
    end

    if Game::BONUS_SPACES.include?( current_space )
      card = Bonus.get_event
      self.bonuses << Bonus.create(
          :bonus_type  => 'card',
          :description => card[:description],
          :spaces      => card[:spaces]
      )
    end
  end

  def current_space
    starting_space + total_spaces
  end

  def total_spaces
    spaces + bonuses_spaces
  end

  def bonuses_spaces
    bonuses.reduce(0) do |sum, bonus|
      sum += bonus.spaces
    end
  end

end
