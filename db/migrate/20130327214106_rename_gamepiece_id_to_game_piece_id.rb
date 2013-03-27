class RenameGamepieceIdToGamePieceId < ActiveRecord::Migration

  def up
    rename_column :players, :gamepiece_id, :game_piece_id
  end

  def down
    rename_column :players, :game_piece_id, :gamepiece_id
  end

end
