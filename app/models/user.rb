class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable, :rememberable, :trackable, :recoverable

  has_many :children, dependent: :destroy
  has_many :reservations
  has_many :schedules, through: :reservations

  validates_presence_of :email
  validates_uniqueness_of :email
  validates_confirmation_of :password

end
