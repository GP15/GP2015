class Zipcode < ActiveRecord::Base

  belongs_to :city

  scope :active, -> { where(active: true) }

end
