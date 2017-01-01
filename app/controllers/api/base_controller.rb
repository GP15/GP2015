class Api::BaseController < ActionController::Base
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :json_request?

  before_action :authorize_request!, :current_api_user

  protected

  def json_request?
    request.format.json?
  end

  def authorize_request!
    unless params[:access_token] == API_ACCESS_TOKEN
      return render json: { success: 'failed', message: 'Wrong API Access Token' }, status: 403
    end
  end

  # def current_api_user
  #   if params[:api_token].present?
  #     @user = User.where(api_token: params[:api_token]).first
  #     if @user.present?
  #       if @user.expired_api_user?
  #         @user.api_token = nil
  #         @user.save!
  #         render json: { error: "Please relogin again!" }, status: 401
  #       end
  #     else
  #       render json: { error: "Unauthorized" }, status: 401
  #     end
  #   end
  # end

end
