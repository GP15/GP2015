module Payment
  def create_customer
    customer = Braintree::Customer.create(first_name: name, email: email)
    self.customer_id = customer.customer.id
    self.save!
  end

  def create_payment_method_token(customer_id, nounce)
    result = Braintree::PaymentMethod.create(
      :customer_id => user.customer_id,
      :payment_method_nonce => nounce
    )
    token = result.payment_method.token
  end

  def create_subscription(plan_id, nounce)
    result = Braintree::Subscription.create(payment_method_token: token, plan_id: plan_id)
    result.subscription.id
  end
end
