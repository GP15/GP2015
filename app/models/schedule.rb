class Schedule < ActiveRecord::Base

  belongs_to :city
  belongs_to :partner
  belongs_to :activity
  belongs_to :klass
  has_many   :reservations
  has_many   :children, through: :reservations

  validates :quantity, presence: true,
                       numericality: { only_integer: true, greater_than: 0 }
end
