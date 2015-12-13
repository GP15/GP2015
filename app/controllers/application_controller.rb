class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout        :layout_by_resource
  before_filter :set_time_zone

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_credit_card_added



  protected

  def layout_by_resource
    if devise_controller? && resource_name == :admin
      "admin"
    else
      "application"
    end
  end

  def set_time_zone
    if current_user
      Time.zone = current_user.time_zone
    elsif current_admin
      Time.zone = current_admin.time_zone
    else
      Time.zone = "Kuala Lumpur"
    end
  end


  # Devise: Redirect user after successful login
  def after_sign_in_path_for(user)
    request.referer == (new_user_session_url) || request.referer == (new_admin_session_url)  ? current_user : new_user_child_path(current_user)
  end

  def configure_permitted_parameters
    new_fields = [:name, :email, :password, :password_confirmation, :location]
    devise_parameter_sanitizer.for(:sign_up).concat new_fields
    devise_parameter_sanitizer.for(:account_update).concat new_fields
  end

  def check_credit_card_added
    if should_subscribe?
      child = current_user.children.without_subscriptions.first
      redirect_to child_path(child), notice: "Please subscribe for #{child.full_name}"
    end
  end

  def should_subscribe?
    current_user.present? &&
    !devise_controller? &&
    (current_user.children.without_subscriptions.length != 0) &&
    not_controller_with_action('children', 'show') &&
    not_controller_with_action('subscriptions', '')
  end

  def not_controller_with_action(controller, action)
    !(params[:controller].eql?(controller) && (action.present? ? params[:action].eql?(action) : true))
  end

end
