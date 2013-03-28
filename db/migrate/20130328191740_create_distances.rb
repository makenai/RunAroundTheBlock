class CreateDistances < ActiveRecord::Migration
  def change
    create_table :distances do |t|
      t.integer :distance
      t.integer :user_id
      t.integer :turn_id

      t.timestamps
    end
  end
end
