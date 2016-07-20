ActiveAdmin.register Question do

  menu :parent => "General"

  permit_params :title, :brain

end