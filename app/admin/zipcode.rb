ActiveAdmin.register Zipcode do

  menu :parent => "Location"

  permit_params :pincode, :city_id, :active

  index do
    selectable_column
    column :pincode
    column :city_id do |zipcode|
      if zipcode.city.present?
        link_to zipcode.city.name, admin_city_path(zipcode.city)
      end
    end
    column :active
    actions
  end


end
