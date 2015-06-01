class Partner < ActiveRecord::Base

  belongs_to :city

  validates :company, :address, presence: true

end
