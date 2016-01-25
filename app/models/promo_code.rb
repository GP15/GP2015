class PromoCode < ActiveRecord::Base
  # has_secure_token :code
  validates :name, :code, :presence => true
  validates :code, :uniqueness => true
end
