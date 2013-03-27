class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.datetime :start_at
      t.datetime :ended_at
      t.integer :winner_game_piece_id
      t.integer :current_turn_number

      t.timestamps
    end
  end
end
