ActiveAdmin.register Partner do

  menu :parent => "Activity Related"

  permit_params :company, :phone, :address, :state, :city_id, :img_url, :featured, :logo, :latitude, :longitude, :email, :user_allowed

  index do
    selectable_column
    column :company
    column :email
    column :city_id
    column :state
    column :phone
    column :featured
    actions
  end

  show do
    attributes_table do
      row :company
      row :email
      row :city_id
      row :state
      row :address
      row :latitude
      row :longitude
      row :phone
      row :featured
      row :user_allowed
      row :img_url do
        image_tag partner.img_url
      end
      row :logo do
        image_tag partner.logo
      end
    end
    active_admin_comments
  end

end
