class CreateGamePieces < ActiveRecord::Migration
  def change
    create_table :game_pieces do |t|
      t.integer :game_id
      t.string :name
      t.string :image_url
      t.integer :last_space

      t.timestamps
    end
  end
end
