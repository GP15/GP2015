class Klass < ActiveRecord::Base

  belongs_to :partner
  belongs_to :activity
  has_many   :schedules

  validates_presence_of :name, :activity_id, :age_start, :age_end, :reservation_limit
  validates_numericality_of :reservation_limit, only_integer: true, greater_than_or_equal_to: 0

  # A class difficulty levels.
  LEVEL = ["Beginner", "Intermediate", "Advanced", "Multilevel"]
end
