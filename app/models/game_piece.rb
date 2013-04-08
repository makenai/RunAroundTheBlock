class GamePiece < ActiveRecord::Base

  attr_accessible :game_id, :image_url, :color, :name
  belongs_to :game
  has_many :players
  has_many :users, :through => :players
  has_many :turns

  TEAMS = [
    { name: 'Brooks',  color: 'red'    },
    { name: 'Saucony', color: 'green'  },
    { name: 'Nike',    color: 'blue'   },
    { name: 'Other',   color: 'yellow' }
  ]
  RAND_MAX_FOR_DEMO = 3
  delegate :current_turn_number, to: :game

  def total_mileage_on(date = Date.yesterday)
    date = DateTime.parse(date.to_s).to_date
    players.inject(0) do |sum, player|
      sum += player.mileage_on(date)
      if Game::DEMO_FLAG
      	sum += rand GamePiece::RAND_MAX_FOR_DEMO
      end
    end
  end

  def average_mileage_on(date = Date.yesterday)
    return 0 if players.none?
    total_mileage_on(date) / players.size
  end

  def get_turn(turn_number)
    self.turns.where(turn_number: turn_number).first
  end

  def todays_turn
    get_turn(current_turn_number)
  end
  alias_method :last_turn, :todays_turn

  def do_turn(turn_number = current_turn_number)
    turn = get_turn( turn_number ) || create_turn( turn_number )
  end

  def finished?
    current_space > Game::BOARD_SPACES
  end

  def space_at(turn_number)
    selected_turns = turns.find_all { |t| t.turn_number <= turn_number }
    selected_turns.reduce(0) do |sum, turn|
      sum += turn.total_spaces
    end
  end

  def current_space
    space_at(current_turn_number)
  end

  def last_space
    space_at(current_turn_number - 1)
  end

  private

  def create_turn(turn_number)
    self.turns.create! do |turn|
      turn.turn_number = turn_number
      turn.starting_space = self.current_space
      turn.spaces = some_algorithm(turn_number)
    end
  end

  def some_algorithm(turn_number)
    start_date   = game.start_at.to_date
    date_of_turn = start_date + (turn_number - 1).days
    average_mileage_on(date_of_turn)
  end


end
