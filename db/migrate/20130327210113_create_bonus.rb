class CreateBonus < ActiveRecord::Migration
  def change
    create_table :bonuses do |t|
      t.integer :turn_id
      t.integer :spaces
      t.string :bonus_type
      t.integer :player_id
      t.text :description
      t.timestamps
    end
  end
end
