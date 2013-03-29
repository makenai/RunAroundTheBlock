class Turn < ActiveRecord::Base
  attr_accessible :game_piece_id, :spaces, :turn_number, :starting_space
  belongs_to :game_piece
  has_many :bonuses

  def process_bonuses(total_spaces)
    # Create bonus objects here. Be idempotent.
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
