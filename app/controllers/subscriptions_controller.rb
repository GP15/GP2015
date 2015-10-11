class SubscriptionsController < ApplicationController
  def new
    @client_token = Braintree::ClientToken.generate(customer_id: current_user.customer_id)
    @subscription = current_user.subscriptions.build
  end

  def create
    @subscription = current_user.subscriptions.build(subscription_params)
    if @subscription.save
      @subscription.sync_subscription(params[:payment_method_nonce])
      redirect_to schedules_path
    else
      render :new
    end
  end

  def show
    @subscription = current_user.subscriptions.find(params[:id])
    @plan = @subscription.plan
  end

  private
  def subscription_params
    params.require(:subscription).permit(:plan_id, :quantity)
  end
end
