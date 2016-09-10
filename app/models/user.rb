class User < ActiveRecord::Base

  ## Devise ##
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :recoverable, :omniauthable, omniauth_providers: [:facebook]

  include Payment

  attr_accessor :referal_code, :being_referred

  ## Associations ##
  has_many :children,         :dependent => :destroy
  has_many :reservations,     :dependent => :destroy
  has_many :schedules,        :through => :reservations
  has_many :subscriptions,    :dependent => :destroy
  has_many :referals
  has_many :referred_tos,     :through => :referals, :source => :user
  has_many :referred_froms,   :through => :referals, :source => :referred_to
  has_many :points, class_name: "RewardPoint"

  ## Validations ##
  validates_presence_of :email, :name, :location
  validates_uniqueness_of :email, :promo_code
  validates_confirmation_of :password


  accepts_nested_attributes_for :children, allow_destroy: true, reject_if: :all_blank

  ## Callbacks ##
  after_create :create_customer, :send_welcome_mail
  before_update :verify_promo_code
  ## Scopes ##
  scope :with_code, ->(code){ find_by(promo_code: code) }


  def able_claim_reward?(amount)
    success = false
    if self.reward_points <= 0
      success = false
    elsif self.reward_points < amount
      success = false
    else
      success = true
    end
    success
  end

  def deduct_reward_points(amount)
    self.claimed_points += amount
    self.save!
  end

  def increase_reward_points(amount)
    increased_amount = actual_reward_points + amount
    write_attribute(:reward_points, increased_amount)
    save!
  end

  def actual_reward_points
    read_attribute(:reward_points)
  end

  def reward_points
    if read_attribute(:reward_points)
      read_attribute(:reward_points) - self.claimed_points
    else
      0
    end
  end

  #--------- Rewards methods

  def should_upgrade?(child_id)
    subs = subscriptions.where( :child_id => child_id).try(:first)
    if subs
      subs.subscription_type.free? && Child.all.find_by_id( child_id).try( :reservations).try(:count).to_i >= 2
    else
      return false
    end
  end
  ## Instance Methods ##
  def create_customer
    customer = Braintree::Customer.create(first_name: name, email: email)
    self.customer_id = customer.customer.id
    self.promo_code = self.generate_promo_code
    self.save!
  end

  def send_welcome_mail
    WelcomeMailer.invite(self).deliver_now
  end

  def total_subscriptions
    subscriptions.sum(:quantity)
  end

  def can_make_reservation_for_partner?(ptnr)
    reservation_made_for_partner(ptnr) < ptnr.user_allowed
  end

  def reservation_allowed_for_partner(ptnr)
    ptnr.user_allowed - reservation_made_for_partner(ptnr)
  end

  def reservation_made_for_partner(ptnr)
    num = 0
    reservations.this_month.map { |reservation| num = num + 1 if reservation.schedule.partner == ptnr}
    return num
  end

  def can_avail_discounted_plans?
    children.count > 1
  end

  def can_have_referal_discounts?
    available_referals.present?
  end

  def available_referals
    referals.where( :rewards_used => false)
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

    # Override devise module
  def self.send_reset_password_instructions(attributes={})
    recoverable = find_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
    if recoverable.persisted?
      if recoverable.encrypted_password.blank?
        recoverable.errors.add(:email, "cannot be reset. Are you connected your social media account?")
      else
        recoverable.send_reset_password_instructions
      end
    end
    recoverable
  end

  private

  def verify_promo_code
    if being_referred
      referred_by = User.find_by_promo_code( referal_code )
      unless referred_by.present? || PromoCode.find_by_code( referal_code ).present?
        errors.add( :referal_code, "Invalid promo code")
        return false
      else
        if referred_by == self
          errors.add( :referal_code, "You can not use your own promo code")
          return false
        end

        if subscriptions.find_by_promo_code( referal_code).present?
          errors.add( :referal_code, "You can not use promo code more than once.")
          return false
        end
      end
    end
  end


end
