class Child < ActiveRecord::Base

  belongs_to :user
  has_many   :reservations, dependent: :destroy
  has_many   :schedules, through: :reservations

  validates_presence_of :first_name, :last_name

end
