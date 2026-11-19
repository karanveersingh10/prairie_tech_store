ActiveAdmin.register Product do
  permit_params :sku,
                :name,
                :description,
                :brand,
                :current_price,
                :stock_quantity,
                :active,
                :category_id,
                :image

  index do
    selectable_column
    id_column
    column :name
    column :sku
    column :brand
    column :category
    column :current_price
    column :stock_quantity
    column :active

    column :image do |product|
      if product.image.attached?
        image_tag product.image.variant(:thumb), width: 60
      else
        "No image"
      end
    end

    actions
  end

  filter :name
  filter :sku
  filter :brand
  filter :category
  filter :active

  form do |f|
    f.inputs "Product Details" do
      f.input :name
      f.input :sku
      f.input :description
      f.input :brand
      f.input :current_price
      f.input :stock_quantity
      f.input :category
      f.input :active
      f.input :image, as: :file

      if f.object.image.attached?
        li do
          image_tag f.object.image.variant(:medium), width: 150
        end
      end
    end

    f.actions
  end

  show do
    attributes_table do
      row :name
      row :sku
      row :description
      row :brand
      row :category
      row :current_price
      row :stock_quantity
      row :active

      row :image do |product|
        if product.image.attached?
          image_tag product.image.variant(:large), width: 250
        else
          "No image uploaded"
        end
      end
    end
  end
end