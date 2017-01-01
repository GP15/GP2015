class Api::UsersController < Api::BaseController

  api :PATCH, '/users/:id', 'Update profile settings'
  param :api_token, String, desc: "This API token will be needed to get authorized."
  param :id, Integer, required: true
  param :user, Hash, desc: "User info" do
    param :name, String, desc: "User's name"
    param :location, String, desc: "User's location"
    param :phone_no, String, desc: "User's Phone No."
  end
  error code: 403, :desc => "Unauthorized"
  formats ['json']
  def update
  end

end