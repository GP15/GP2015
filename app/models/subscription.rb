class Subscription < ActiveRecord::Base
  ## Associations ##
  belongs_to :user
  belongs_to :child
  belongs_to :subscription_type

  ## Validations ##
  validates :child_id, :subscription_type_id, presence: true
  validate  :valid_promo_code

  after_create :send_subscription_notification

  ## Instance Methods ##
  def sync_subscription(nounce)
    result = Braintree::PaymentMethod.create(
      :customer_id => user.customer_id,
      :payment_method_nonce => nounce
    )
    plan_id = "RM#{subscription_type.price}"
    discount_id = "RM20"
    if result.success?
      token = result.payment_method.token
      result = Braintree::Subscription.create(
                            :payment_method_token => token,
                            :plan_id => plan_id,
                            :discounts =>
                                      {
                                        :add => [ :inherited_from_id => discount_id,
                                                  :quantity          => discounts_quantity
                                                ]
                                      })

      if result.success?
        referred_by.referals.build(:referred_to_id => user.id).save     if promo_code.present? && referred_by.present?
        self.subscription_id = result.subscription.id
        self.start_date = DateTime.now
        self.save!
      else
        false
      end
    else
      false
    end
  end

  def discounts_quantity
    quantity = 0
    quantity = quantity + 1 if promo_code.present?
    quantity = quantity + 1 if user.can_avail_discounted_plans?
    if user.can_have_referal_discounts?
      if (subscription_type.price.to_i - quantity*20) > 20
        user.available_referals.first.update_attributes( :rewards_used => true)
        quantity = quantity + 1
      end
    end
    return quantity
  end

  def subscriped_on
    created_at.strftime('%d,%B-%y at %H:%M %p')
  end

  def plan
    p = Plan.new
    plan = p.get_plan(plan_id)
  end

  def renewal_date
    created_at + 30.days if created_at
  end

  def print_status
    status ? 'Active' : 'De-Active'
  end

  def unsubscribe
    unless subscription_type == SubscriptionType.free
      result = Braintree::Subscription.cancel(subscription_id)
    end
    self.update_attributes(status: false, cancelled_on: DateTime.now)
  end

  def referred_by
    User.find_by_promo_code( promo_code)
  end

  def send_subscription_notification
    SubscriptionMailer.invite(self.user).deliver_now
  end

  private

  def valid_promo_code
    if promo_code.present?
      unless referred_by.present? || PromoCode.find_by_code( promo_code)
        errors.add( :promo_code, "Invalid promo code")
      else
        if user.subscriptions.where.not( :id => self.id).where(:promo_code => promo_code ).present?
          errors.add( :promo_code, "You can not use your own promo code")
        end
      end
    end
  end

end
