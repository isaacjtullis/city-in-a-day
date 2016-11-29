class RemoveColumnsFromTrails < ActiveRecord::Migration[5.0]
  def change
    remove_column :trails, :location, :string
    remove_column :trails, :description, :string
    remove_column :trails, :price, :string
    remove_column :trails, :mood, :string
  end
end
