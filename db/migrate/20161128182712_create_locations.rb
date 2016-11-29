class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :name, null: false
      t.string :location, null: false
      t.string :description, null: false
      t.string :price, null: false
      t.string :mood, null: false
      t.integer :trail_id, null: false
    end
  end
end
