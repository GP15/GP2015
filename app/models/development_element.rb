class DevelopmentElement < ActiveRecord::Base

  has_many :klass_elements
  has_many :klass, through: :klass_elements

end
