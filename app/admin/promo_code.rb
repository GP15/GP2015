ActiveAdmin.register PromoCode do

  menu :parent => "General"

  permit_params :code, :name

end
