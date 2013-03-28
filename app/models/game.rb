class Game < ActiveRecord::Base
  attr_accessible :current_turn_number, :ended_at, :start_at, :winner_game_piece_id
  has_many :game_pieces

  MAX_SPACES = 26

  def self.current
    Game.where( winner_game_piece_id: nil ).order( 'start_at desc' ).first || Game.create( start_at: Time.now, current_turn_number: 0 )
  end

  def self.run
    game = Game.current

    # update the turn number
    puts("Game turn: #{game.current_turn_number}")
    game.current_turn_number += 1
    game.save

    # update all of the game pieces and check for winner
    game_pieces = game.game_pieces;
    game_pieces.each do |game_piece|
      game_piece.do_turn
      if(game_piece.finished?)
        game.crossed_finish(game_piece)
        break
      else
        puts("updated space: #{game_piece.last_space}")
      end
    end

  end

  def crossed_finish(game_piece)
    puts("#{game_piece.name} is a winner!")
  end
end
