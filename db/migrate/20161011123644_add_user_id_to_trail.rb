class AddUserIdToTrail < ActiveRecord::Migration[5.0]
  def up
    add_column :trails, :user_id, :integer, null: false
  end
  def down
    remove_column :trails, :user_id, :integer, null: false
  end
end
