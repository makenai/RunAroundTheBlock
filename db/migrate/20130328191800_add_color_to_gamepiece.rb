class AddColorToGamepiece < ActiveRecord::Migration
  def change
    add_column :game_pieces, :color, :string
  end
end
