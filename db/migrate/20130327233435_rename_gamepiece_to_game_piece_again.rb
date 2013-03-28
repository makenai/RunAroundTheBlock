class RenameGamepieceToGamePieceAgain < ActiveRecord::Migration
  def up
    rename_column :turns, :gamepiece_id, :game_piece_id
  end

  def down
    rename_column :turns, :gamepiece_id, :game_piece_id
  end
end
