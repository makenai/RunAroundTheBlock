class GamesController < ApplicationController


  def current
    @game = Game.current
    @game_data = @game.game_data( current_user )
    @current_turn_number = @game.current_turn_number
  end

  def index
    @games = Game.order('start_at asc').all
  end

end
