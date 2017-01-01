class Api::RegistrationsController < Api::BaseController

  api :POST, '/register', 'Sign Up'
  param :id, :number
  param :user, Hash, desc: "User info" do
    param :email, String, desc: "Username for Sign Up", required: true
    param :password, String, desc: "Password for Sign Up", required: true
    param :confirmed_password, String, desc: "Confirmed Password for Sign Up", required: true
  end
  error code: 403, desc: "Unauthorized"
  formats ['json']
  def create
  end

  api :GET, '/facebook_callback', 'Facebook Sign Up'
  error code: 403, desc: "Unauthorized"
  formats ['json']
  def facebook
  end

end