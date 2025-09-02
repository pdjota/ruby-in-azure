class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :barcode

      t.timestamps
    end
    add_index :products, :barcode, unique: true
  end
end
