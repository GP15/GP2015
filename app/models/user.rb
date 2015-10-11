class User < ActiveRecord::Base
include Payment

  devise :database_authenticatable, :registerable, :rememberable, :trackable

  has_many :children, dependent: :destroy
  has_many :reservations
  has_many :schedules, through: :reservations
  has_many :subscriptions, dependent: :destroy

  validates_presence_of :email, :name, :location
  validates_uniqueness_of :email
  validates_confirmation_of :password

  after_create :create_customer

  def create_customer
    customer = Braintree::Customer.create(first_name: name, email: email)
    self.customer_id = customer.customer.id
    self.save!
  end

  def total_subscriptions
    subscriptions.sum(:quantity)
  end

  def can_add_child?
    children.count + 1 < total_subscriptions
  end
end
