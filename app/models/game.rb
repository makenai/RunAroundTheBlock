class Game < ActiveRecord::Base
  attr_accessible :current_turn_number, :ended_at, :start_at, :winner_game_piece_id
  has_many :game_pieces

  BONUS_SPACES = [3, 7, 13, 17, 23]
  DEMO_FLAG = true
  DEMO_GAME_PIECES = GamePiece::TEAMS.sample(2)
  BOARD_SPACES = 26


  def self.current
    game = Game.where( winner_game_piece_id: nil ).order( 'start_at desc' ).first || Game.create( start_at: Time.now, current_turn_number: 0 )
    # assign random game pieces for demo games without any
    if Game::DEMO_FLAG && game.game_pieces.count == 0
      game.assign_random_game_pieces
    end
    game
  end

  def self.space_classes(i)
    classes = ""
    if Game::BONUS_SPACES.include? (i+1)
      classes = "bonus-space"
    end
    "#{classes}"
  end

  def self.run
    game = Game.current

    # update all of the game pieces and check for winner
    game_pieces = game.game_pieces

    # trip out if there aren't any game pieces, no point wasting turns
    if game_pieces.count == 0
      return "no game pieces yet"
    end

    # if this is the first real turn, update start to today
    if game.current_turn_number == 0
      game.start_at = Time.now
    end

    # update current turn number
    if DEMO_FLAG
      game.current_turn_number += 1
    else
      game.current_turn_number = (Time.now - game.start).to_i / 1.day
    end

    # have to save turn number update, other objects use it directly
    # this could get kind of hairy, but its a hackathon!
    game.save

    game_pieces.each do |game_piece|
      game_piece.do_turn(game.current_turn_number)
      if game_piece.finished?
        game.crossed_finish(game_piece)
        break
      else
        puts("#{game_piece.name} is at #{game_piece.current_space}")
      end
    end
  end

  def crossed_finish(game_piece)
    puts("#{game_piece.name} is a winner!")

    self.ended_at = Time.now
    self.winner_game_piece_id = game_piece.id
    self.save
  end

  def assign_random_game_pieces
    game_id = self.id
    for i in 0...Game::DEMO_GAME_PIECES.count
      name = Game::DEMO_GAME_PIECES[i][:name]
      game_piece = GamePiece.create( game_id: game_id, name: name )
      user = User.order("RANDOM()").first
      #if user.game_pieces.where(game_id: game_id).count == 0
        player = Player.create( user_id: user.id, game_piece_id: game_piece.id, turn_joined: 0 )
      #end
    end
  end
end
