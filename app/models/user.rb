class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable, :validatable
  devise :database_authenticatable, :registerable, :rememberable,
         :recoverable, :trackable

  has_many :children, dependent: :destroy
  has_many :reservations

end
