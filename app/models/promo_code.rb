class PromoCode < ActiveRecord::Base
  has_secure_token :code
  validates :name, :presence => true
  validates :code, :uniqueness => true
end
