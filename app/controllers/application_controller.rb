class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  # Devise: Redirect user after successful login
  def after_sign_in_path_for(user)
    request.referer == (new_user_session_url) || request.referer == (new_admin_session_url)  ? current_user : schedules_path
  end

  def configure_permitted_parameters
    new_fields = [:name, :email, :password, :password_confirmation, :location]
    devise_parameter_sanitizer.for(:sign_up).concat new_fields
    devise_parameter_sanitizer.for(:account_update).concat new_fields
  end
end
