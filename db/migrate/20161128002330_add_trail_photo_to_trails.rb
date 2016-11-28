class AddTrailPhotoToTrails < ActiveRecord::Migration[5.0]
  def change
     add_column :trails, :trail_photo, :string
  end
end
