class User < ActiveRecord::Base

  ## Devise ##
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :recoverable

  include Payment

  attr_accessor :referal_code, :being_referred

  ## Associations ##
  has_many :children, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_many :schedules, through: :reservations
  has_many :subscriptions, dependent: :destroy

  ## Validations ##
  validates_presence_of :email, :name, :location
  validates_uniqueness_of :email
  validates_confirmation_of :password

  ## Callbacks ##
  after_create :create_customer
  before_update :verify_promo_code
  ## Scopes ##
  scope :with_code, ->(code){ find_by(promo_code: code) }

  ## Instance Methods ##
  def create_customer
    customer = Braintree::Customer.create(first_name: name, email: email)
    self.customer_id = customer.customer.id
    self.promo_code = self.generate_promo_code
    self.save!
  end

  def total_subscriptions
    subscriptions.sum(:quantity)
  end

  def can_avail_discounted_plans?
    children.count > 1
  end

  def customer
    Braintree::Customer.find(customer_id)
  end

  def generate_promo_code
    code = ''
    begin
      code = SecureRandom.urlsafe_base64(7)
    end while User.with_code(code).nil?
    code
  end

  private

  def verify_promo_code
    if being_referred
      referred_by = User.find_by_promo_code( referal_code )
      unless referred_by
        errors.add( :referal_code, "Invalid promo code")
        return false
      else
        if referred_by == self
          errors.add( :referal_code, "You can not use your own promo code")
          return false
        end
      end
    end
  end


end
