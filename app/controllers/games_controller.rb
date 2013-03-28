class GamesController < ApplicationController


  def current
    @game_pieces = Game.current.game_pieces
  end

end