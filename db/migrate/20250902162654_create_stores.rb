class CreateStores < ActiveRecord::Migration[8.0]
  def change
    create_table :stores do |t|
      t.string :name
      t.text :address
      t.string :contact_info

      t.timestamps
    end
  end
end
