class SubscriptionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:charged_successfully]
  before_action :set_child, except: [:charged_successfully]
  def new
    @client_token = Braintree::ClientToken.generate(customer_id: current_user.customer_id)
    @subscription = @child.build_subscription
  end

  def create
    @subscription = @child.build_subscription(subscription_params)
    @subscription.user = current_user
    if @subscription.save
      if @subscription.sync_subscription(params[:payment_method_nonce])
        redirect_to schedules_path, notice: "You have subscribed successfully"
      else
        @subscription.destroy
        redirect_to child_path(@child), notice: "Please try again"
      end
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

  def charged_successfully
    webhook_notification = Braintree::WebhookNotification.parse(params["bt_signature"],params["bt_payload"])
    if webhook_notification.subscription.present?
      subscription = Subscription.find_by(subscription_id: webhook_notification.subscription.id)
      subscription.update_attributes(renewal_date: DateTime.now + 30.days, start_date: DateTime.now)
    end
    render nothing: true, status: 200
  end

  private
  def set_child
    @child = current_user.children.find(params[:child_id])
  end

  def subscription_params
    params.require(:subscription).permit(:plan_id)
  end
end
