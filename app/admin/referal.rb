ActiveAdmin.register Referal do

  menu :parent => "General"

  permit_params :user_id, :referred_to_id, :rewards_used

end
