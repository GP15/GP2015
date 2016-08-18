ActiveAdmin.register Zipcode do

  menu :parent => "Location"

  permit_params :pincode, :city_id, :active


end
