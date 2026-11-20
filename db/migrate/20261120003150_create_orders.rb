class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.string :customer_name
      t.string :email
      t.text :address
      t.string :city
      t.string :province
      t.string :postal_code
      t.decimal :subtotal
      t.decimal :tax
      t.decimal :total
      t.string :status

      t.timestamps
    end
  end
end
