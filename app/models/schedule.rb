class Schedule < ActiveRecord::Base

  belongs_to :klass
  belongs_to :partner

  validates :quantity, presence: true,
                       numericality: { only_integer: true, greater_than: 0 }
end
