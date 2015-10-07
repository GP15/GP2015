class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable, :rememberable, :trackable

  has_many :children, dependent: :destroy
  has_many :reservations
  has_many :schedules, through: :reservations

  validates_presence_of :email, :name, :location
  validates_uniqueness_of :email
  validates_confirmation_of :password
end
