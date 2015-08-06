class Reservation < ActiveRecord::Base

  belongs_to :child
  belongs_to :schedule
  belongs_to :user

end
