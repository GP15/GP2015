class SubscriptionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:charged_successfully]
  before_action :set_child, except: [:charged_successfully]
  def new
    paid_subscription_ids = SubscriptionType.paid.pluck(:id)

    if current_user.subscriptions.where(subscription_type_id: paid_subscription_ids).active.size >= 1
      @packages = SubscriptionType.onward_child_paid_packages.asc
    else
      @packages = SubscriptionType.paid.asc
    end
    @client_token = Braintree::ClientToken.generate(customer_id: current_user.customer_id)
    if @child.subscription.present?
      @subscription = @child.subscription
    else
      @subscription = @child.build_subscription
    end
    @user = current_user
  end

  def create
    @user = current_user
    @subscription = @child.build_subscription(subscription_params)
    @subscription.user = @user
    if @subscription.save
      unless @subscription.subscription_type == SubscriptionType.free
        if @subscription.sync_subscription(params[:payment_method_nonce])
          redirect_to schedules_path, notice: "You have subscribed successfully"
        else
          @subscription.destroy
          redirect_to child_path(@child), notice: "Please try again"
        end
      else
        redirect_to schedules_path, notice: "You free subscription added successfully."
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
    params.require(:subscription).permit( :promo_code, :subscription_type_id)
  end
end
