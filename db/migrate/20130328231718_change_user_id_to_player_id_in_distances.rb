class ChangeUserIdToPlayerIdInDistances < ActiveRecord::Migration
  def up
    remove_column :distances, :user_id, :integer
    add_column :distances, :player_id, :integer
  end

  def down
    remove_column :distances, :player_id, :integer
    add_column :distances, :user_id, :integer
  end
end
