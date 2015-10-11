class Subscription < ActiveRecord::Base
  ## Associations ##
  belongs_to :user

  ## Instance Methods ##
  def sync_subscription(nounce)
    result = Braintree::PaymentMethod.create(
      :customer_id => user.customer_id,
      :payment_method_nonce => nounce
    )
    token = result.payment_method.token
    (1..quantity).each do
      result = Braintree::Subscription.create(payment_method_token: token, plan_id: plan_id)
      self.subscription_ids << result.subscription.id
    end
    self.save!
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
end
