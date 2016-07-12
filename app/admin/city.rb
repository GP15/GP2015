ActiveAdmin.register City do

  menu :parent => "Location"

  permit_params :name

end
