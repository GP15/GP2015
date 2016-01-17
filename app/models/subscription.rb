class Subscription < ActiveRecord::Base
  ## Associations ##
  belongs_to :user
  belongs_to :child
  belongs_to :subscription_type

  ## Validations ##
  validates :child_id, :subscription_type_id, presence: true
  validate  :valid_promo_code

  ## Instance Methods ##
  def sync_subscription(nounce)
    result = Braintree::PaymentMethod.create(
      :customer_id => user.customer_id,
      :payment_method_nonce => nounce
    )
    if result.success?
      token = result.payment_method.token
      result = Braintree::Subscription.create(
                            :payment_method_token => token,
                            :plan_id => plan_id,
                            :discounts =>
                                      {
                                        :add => [ :amount => "RM20"]
                                      })
      if result.success?
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

  def subscriped_on
    created_at.strftime('%d,%B-%y at %H:%M %p')
  end

  def plan
    p = Plan.new
    plan = p.get_plan(plan_id)
  end

  def renewal_date
    created_at + 30.days
  end

  def print_status
    status ? 'Active' : 'De-Active'
  end

  def unsubscribe
    result = Braintree::Subscription.cancel(subscription_id)
    self.update_attributes(status: false, cancelled_on: DateTime.now)
  end

  private

  def valid_promo_code
    if promo_code.present?
      referred_by = User.find_by_promo_code( promo_code)
      unless referred_by
        errors.add( :promo_code, "Invalid promo code")
      else
        errors.add( :promo_code, "You can not use your own promo code")   if referred_by == user
      end
    end
  end

end
