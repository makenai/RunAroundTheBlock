class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :gamepiece_id
      t.integer :user_id
      t.integer :turn_joined

      t.timestamps
    end
  end
end
