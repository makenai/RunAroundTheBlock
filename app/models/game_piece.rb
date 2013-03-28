class GamePiece < ActiveRecord::Base

  attr_accessible :game_id, :image_url, :last_space, :name
  belongs_to :game
  has_many :players
  has_many :turns

  def total_mileage_on(date = Date.yesterday)
    date = DateTime.parse(date.to_s).to_date
    players.inject(0) do |sum, player|
      sum += player.mileage_on(date)
    end
  end

  def average_mileage_on(date = Date.yesterday)
    return 0 if players.none?
    total_mileage_on(date) / players.size
  end

  def find_turn(turn_number)
    self.turns.where(turn_number: turn_number).first
  end

  def todays_turn
    find_turn(game.current_turn_number)
  end

  def do_turn(turn_number = game.current_turn_number)
    turn = find_turn(turn_number) || create_turn(turn_number)
    turn.process_bonuses
    animate
  end

  def animate
    # Something fancy here?
    # We may need to store last_space in the session data?
    update_attribute :last_space, current_space
  end

  def current_space
    turns.reduce(0) do |sum, turn|
      sum += turn.total_spaces
    end
  end

  def finished?
    current_space > Game::MAX_SPACES
  end

  private

  def create_turn(turn_number)
    self.turns.create! do |turn|
      turn.turn_number = turn_number
      turn.spaces = some_algorithm(turn_number)
    end
  end

  def some_algorithm(turn_number)
    start_date   = game.start_at.to_date
    date_of_turn = start_date + (turn_number - 1).days
    average_mileage_on(date_of_turn)
  end


end
