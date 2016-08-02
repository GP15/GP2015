class City < ActiveRecord::Base

  has_many :schedules
  has_many :klass
  has_many :zipcodes

  validates :name, presence: true

end
