ActiveAdmin.register Order do
  permit_params :status

  filter :id
  filter :customer_name
  filter :email
  filter :status
  filter :created_at

  index do
    selectable_column
    id_column
    column :customer_name
    column :email
    column :total do |order|
      number_to_currency(order.total)
    end
    column :status
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :customer_name
      row :email
      row :address
      row :city
      row :province
      row :postal_code
      row :subtotal do |order|
        number_to_currency(order.subtotal)
      end
      row :tax do |order|
        number_to_currency(order.tax)
      end
      row :total do |order|
        number_to_currency(order.total)
      end
      row :status
      row :created_at
    end

    panel "Ordered Products" do
      table_for order.order_items do
        column("Product") { |item| item.product.name }
        column :quantity
        column("Unit Price") { |item| number_to_currency(item.unit_price) }
        column("Line Total") do |item|
          number_to_currency(item.quantity * item.unit_price)
        end
      end
    end
  end

  form do |f|
    f.inputs "Update Order Status" do
      f.input :status, as: :select,
              collection: %w[pending processing shipped completed cancelled]
    end
    f.actions
  end
end
