class SubscriptionsController < ApplicationController
  before_action :set_child
  def new
    @client_token = Braintree::ClientToken.generate(customer_id: current_user.customer_id)
    @subscription = @child.build_subscription
  end

  def create
    @subscription = @child.build_subscription(subscription_params)
    @subscription.user = current_user
    if @subscription.save
      @subscription.sync_subscription(params[:payment_method_nonce])
      redirect_to schedules_path, notice: "You have subscribed successfully"
    else
      render :new
    end
  end

  def show
    @subscription = @child.subscription
    @plan = @subscription.plan
  end

  def destroy
    @subscription = @child.subscription
    @subscription.unsubscribe
    redirect_to schedules_path, notice: "You have unsubscribed successfully"
  end

  private
  def set_child
    @child = current_user.children.find(params[:child_id])
  end

  def subscription_params
    params.require(:subscription).permit(:plan_id)
  end
end
