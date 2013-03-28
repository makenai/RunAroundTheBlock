class AddStartingSpaceToTurn < ActiveRecord::Migration
  def change
    add_column :turns, :starting_space, :integer
  end
end