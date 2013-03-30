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
        starting_space: turn.try(:starting_space) || 0,
        spaces: turn.try(:spaces) || 0,
        is_current_user: game_piece.users.include?( current_user ),
        bonuses: turn.bonuses.collect { |b| b.to_hash },
        players: game_piece.players.collect { |p| { name: p.user.name, id: p.id } }
      }
      @game_data.push( data )
    end
  end

  def index
    @games = Game.order('start_at asc').all
  end

end