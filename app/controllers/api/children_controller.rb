class Api::ChildrenController < Api::BaseController

  api :POST, '/children', 'This API will create one new child based on the user'
  param :api_token, String, desc: "This API token will be needed to get authorized."
  param :child, Hash, desc: "Child Info" do
    param :fullname, String, desc: "Child's fullname", required: true
    param :birth_year, Integer, desc: "Child's birth year", required: true
    param :gender, ["male","female"], desc: "Child's gender", required: true
  end
  error code: 403, desc: "Unauthorized"
  formats ['json']
  def create
  end

  api :GET, '/children', 'This API will list children based on the user'
  param :api_token, String, desc: "This API token will be needed to get authorized."
  error code: 403, desc: "Unauthorized"
  description "This API will list children based on the user"
  formats ['json']
  def index
  end


  api :GET, '/children/:id/curated', 'Get a list of curated activities based on the child'
  param :api_token, String, desc: "This API token will be needed to get authorized."
  param :id, Integer, desc: "Child'id"
  error code: 403, desc: "Unauthorized"
  formats ['json']
  def curated
  end

  api :GET, '/children/:id/development_elements', 'Display all the development elements based on the child'
  param :api_token, String, desc: "This API token will be needed to get authorized."
  param :id, Integer, desc: "Child'id"
  error code: 403, :desc => "Unauthorized"
  formats ['json']
  def development_elements
  end

end