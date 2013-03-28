class RemoveLastSpaceFromGamePieces < ActiveRecord::Migration
  def up
    remove_column :game_pieces, :last_space
  end

  def down
    add_column :game_pieces, :last_space, :integer
  end
end
