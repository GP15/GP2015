class Users::RegistrationsController < Devise::RegistrationsController

  before_filter :configure_permitted_parameters

  def new
    if params[:step] == 'complete'
      build_resource(sign_up_params)
      @validatable = devise_mapping.validatable?
      if @validatable
        @minimum_password_length = resource_class.password_length.min
      end
    else
      session[:omniauth] = nil
      super
    end
  end

  def create
    super
    session[:omniauth] = nil unless resource.new_record?
  end

  def update
    super
  end

  def edit
    super
  end

  def build_resource(*args)
    super
    auth = session[:omniauth]
    if auth
      resource.email = auth['info']['email'] if auth['info']['email'] #twitter dont return email
      resource.name = auth['info']['name']
      resource.provider = auth['provider']
      resource.token = auth['credentials']['token']
      resource.uid = auth['uid']
      resource.valid?
    end
  end

  def destroy
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u|
      u.permit(:email, :password, :location)
    }
  end

end