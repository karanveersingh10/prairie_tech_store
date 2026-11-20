
ActiveAdmin.register ContactPage do
  permit_params :title, :content, :email, :phone, :address

  filter :title
  filter :email

  index do
    selectable_column
    id_column
    column :title
    column :email
    column :phone
    actions
  end

  form do |f|
    f.inputs "Contact Page Details" do
      f.input :title
      f.input :content
      f.input :email
      f.input :phone
      f.input :address
    end
    f.actions
  end
end
