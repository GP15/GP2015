ActiveAdmin.register ReservationCancellation do

 menu :parent => "Reservation Related"

 permit_params :transaction_id, :amount, :reservation_id, :user_id, :card_type, :last4, :child_id, :created_at, :updated_at

end
