class AddOrderToLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :order, :string
  end
end
