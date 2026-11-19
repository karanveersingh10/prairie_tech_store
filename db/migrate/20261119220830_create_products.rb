class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.references :category, null: false, foreign_key: true
      t.string :sku
      t.string :name
      t.text :description
      t.string :brand
      t.decimal :current_price
      t.integer :stock_quantity
      t.boolean :active

      t.timestamps
    end
  end
end
