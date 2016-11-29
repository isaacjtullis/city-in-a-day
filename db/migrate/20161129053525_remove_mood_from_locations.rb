class RemoveMoodFromLocations < ActiveRecord::Migration[5.0]
  def change
    remove_column :locations, :mood, :string
  end
end
