class CreateContactPages < ActiveRecord::Migration[7.2]
  def change
    create_table :contact_pages do |t|
      t.string :title
      t.text :content
      t.string :email
      t.string :phone
      t.text :address

      t.timestamps
    end
  end
end
