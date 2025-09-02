class CreateInventories < ActiveRecord::Migration[8.0]
  def change
    create_table :inventories do |t|
      t.references :product, null: false, foreign_key: true
      t.references :store, null: false, foreign_key: true
      t.integer :available_quantity, default: 0

      t.timestamps
    end

    add_index :inventories, [ :product_id, :store_id ], unique: true
  end
end
