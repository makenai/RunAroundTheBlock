class GamesController < ApplicationController


  def current
    @game_pieces = Game.current.game_pieces || []
    @game_data = [
    ]
    @game_pieces.each do |game_piece|
      turn = game_piece.todays_turn
      data = {
        id: game_piece.id,
        name: game_piece.name,
        color: game_piece.color,
        starting_space: turn.try(:starting_space),
        spaces: turn.try(:spaces),
        bonuses: []
      }
      @game_data.push( data )
    end
  end

  def index
    @games = Game.order('start_at asc').all
  end

end