class Klass < ActiveRecord::Base

  belongs_to :partner
  belongs_to :activity
  has_many   :schedules

  validates :name, presence: true
  validates :reservation_limit, presence: true,
            numericality: { only_integer: true, greater_than: -1 }

  # A class difficulty levels.
  LEVEL = ["Beginner", "Intermediate", "Advanced", "Multilevel"]
end
