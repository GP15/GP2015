ActiveAdmin.register ContactRequest do

  menu :parent => "General"

  permit_params :email, :zipcode

end
