class ReservationCancellation < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :user
  belongs_to :child
end
