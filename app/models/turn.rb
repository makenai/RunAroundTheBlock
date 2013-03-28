class Turn < ActiveRecord::Base
  attr_accessible :game_piece_id, :spaces, :turn_number
  belongs_to :game_piece
  has_many :bonuses

  def process_bonuses
    # Create bonus objects here. Be idempotent.
  end

  def total_spaces
    spaces + bonuses.spaces.reduce(&:+)
  end

end
