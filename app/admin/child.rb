ActiveAdmin.register Child do

  permit_params :fullname, :first_name, :last_name, :birth_year, :user_id

end
