class Create < ActiveRecord::Migration[5.0]
  def change
    create_table :favorites do |t|
      t.integer :trail_id, null: false
      t.integer :user_id, null: false
    end
  end
end
