class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :runkeeper_id
      t.string :name
      t.string :nickname
      t.string :location
      t.string :gender
      t.string :image_url
      t.string :thumb_url

      t.timestamps
    end
  end
end
