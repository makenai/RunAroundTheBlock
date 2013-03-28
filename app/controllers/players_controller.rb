class PlayersController < ApplicationController

  def create

    current_game = Game.current
    answer = params[:player][:answer]

    color, name = nil, nil
    GamePiece::TEAMS.each do |team|
      if answer == team[:color]
        name  = team[:name]
        color = team[:color]
      end
    end
    
    # NOTE: If not hackathon, make sure they can't create arbitrary pieces by filtering answer
    unless game_piece = current_game.game_pieces.where( name: answer ).first
      game_piece = GamePiece.create( 
        game_id: Game.current.id, 
        name: name,
        color: color
      )
    end

    player = Player.create( user_id: current_user.id, game_piece_id: game_piece.id, turn_joined: current_game.current_turn_number )

    redirect_to root_url

  end

end