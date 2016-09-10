ActiveAdmin.register PartnershipSignUp do

  menu :parent => "General"

  permit_params :city, :company_name, :website, :name, :email, :phone, :address, :comments

end
