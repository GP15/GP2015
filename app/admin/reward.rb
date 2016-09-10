ActiveAdmin.register Reward do

  menu :parent => "General"

  permit_params :title, :description, :point, :image

end
