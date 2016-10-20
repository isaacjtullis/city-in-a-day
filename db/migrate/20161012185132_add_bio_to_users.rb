class AddBioToUsers < ActiveRecord::Migration[5.0]
  def up
    add_column :users, :bio, :string
  end

  def down
    remove_column :users, :bio, :string
  end
end
