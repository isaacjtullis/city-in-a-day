class AddMoodToTrails < ActiveRecord::Migration[5.0]
  def change
    add_column :trails, :mood, :string, null: false
  end
end
