class Admin < ActiveRecord::Base

  devise :database_authenticatable, :rememberable, :trackable, :lockable

  validates_presence_of :email
  validates_uniqueness_of :email
  validates_confirmation_of :password

end
