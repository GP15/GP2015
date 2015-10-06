class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_time_zone

  protected

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
    current_user
  end

end
