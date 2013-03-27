class CreateTurns < ActiveRecord::Migration
  def change
    create_table :turns do |t|
      t.integer :gamepiece_id
      t.integer :turn_number
      t.integer :spaces

      t.timestamps
    end
  end
end
