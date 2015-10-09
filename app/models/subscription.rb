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
end
