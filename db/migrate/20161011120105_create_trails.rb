class CreateTrails < ActiveRecord::Migration[5.0]
  def change
    create_table :trails do |t|
      t.string :name, null: false
      t.string :location, null: false
      t.string :description, null: false
      t.string :price, null: false
      t.string :mood, null: false 
    end
  end
end
