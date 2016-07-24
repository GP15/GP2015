class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController


  def facebook
    auth = request.env["omniauth.auth"]
    params = request.env["omniauth.params"] || {}
    exist_user = User.find_by_provider_and_uid(auth.provider, auth.uid)

    puts auth.inspect
    puts params.inspect
    # Check whether any user is logged in

    respond_to do |format|

      format.html do
        if exist_user.present?
          # Check when trying to login
          # Service found in db and login the user and update facebook details
          # authentication.update_facebook_token(auth['credentials']['token'])

          sign_in_and_redirect exist_user
          set_flash_message(:notice, :success, kind: auth['provider'].capitalize) if is_navigational_format?
        else
          # New user sign up / login
          flash[:notice] = "Successfully authorized. One more step to complete your registration"
          session[:omniauth] = auth.except('extra')
          redirect_to new_user_registration_path(step: 'complete')
        end
      end
    end

  end

  def failure
    respond_to do |format|
      format.json do
        render json: { error: true }
      end

      format.html do
        super
      end
    end
  end

end