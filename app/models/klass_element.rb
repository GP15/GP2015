class KlassElement < ActiveRecord::Base

  belongs_to :development_element
  belongs_to :klass

end
