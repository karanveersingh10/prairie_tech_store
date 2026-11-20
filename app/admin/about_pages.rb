
ActiveAdmin.register AboutPage do
  permit_params :title, :content

  filter :title

  index do
    selectable_column
    id_column
    column :title
    column :content
    actions
  end

  form do |f|
    f.inputs "About Page Details" do
      f.input :title
      f.input :content
    end
    f.actions
  end
end
