class Game < ActiveRecord::Base
  attr_accessible :current_turn_number, :ended_at, :start_at, :winner_game_piece_id
  has_many :game_pieces


  def self.current
    Game.where( winner_game_piece_id: nil ).order( 'start_at desc' ).first
  end

  def self.run

    # Check for a current game
    if Game.current == nil
      Game.create( start_at: Time.now, current_turn_number: 0 )
    end
    game = Game.current





  end

end
