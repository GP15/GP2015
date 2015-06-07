class Klass < ActiveRecord::Base

  belongs_to :partner
  belongs_to :activity

  validates :name, presence: true

  LEVEL = ["Beginner", "Intermediate", "Advanced", "Multilevel"]
end
