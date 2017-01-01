class Api::SessionsController < Api::BaseController

  api :POST, '/login', 'Normal Login'
  param :user, Hash, desc: "User info" do
    param :email, String, desc: "Username for login", required: true
    param :password, String, desc: "Password for login", required: true
  end
  formats ['json']
  def create
  end

  api :POST, '/facebook_callback', 'Facebook Login'
  param :user, Hash, desc: "User info" do
    param :email, String, desc: "Username for login", required: true
    param :token, String, desc: "Token for login", required: true
  end
  formats ['json']
  def facebook
  end

  api :POST, '/forgot_password', 'Forget Password'
  param :email, String
  formats ['json']
  def forget
  end

  api :GET, '/logout', 'Logout section'
  param :api_token, String, desc: "This API token will be needed to get authorized."
  formats ['json']
  def destroy

  end

end