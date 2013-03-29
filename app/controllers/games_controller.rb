class GamesController < ApplicationController


  def current
    @game_pieces = Game.current.game_pieces
  end

  def index
    @games = Game.order('start_at asc').all
  end

end