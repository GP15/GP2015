class Klass < ActiveRecord::Base

  belongs_to :partner
  belongs_to :activity

  validates :name, presence: true

  # A class difficulty levels.
  LEVEL = ["Beginner", "Intermediate", "Advanced", "Multilevel"]
end
