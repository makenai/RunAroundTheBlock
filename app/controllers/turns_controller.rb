class TurnsController < ApplicationController

  def show
    @game = Game.find( params[:game_id] )
    @current_turn_number = params[:id].to_i
    @game_data = @game.game_data( current_user, @current_turn_number )
    render 'games/current'
  end

end
