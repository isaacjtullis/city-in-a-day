class AddPhotosToLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :photos, :string
  end
end
