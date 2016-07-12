ActiveAdmin.register Reservation do

  menu :parent => "Reservation Related"

  permit_params :child_id, :schedule_id, :user_id, :deleted, :deleted_at

end
