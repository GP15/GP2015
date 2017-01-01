class Api::SubscriptionsController < Api::BaseController

  api :GET, '/subscriptions', 'Get a list of subscription packages'
  param :api_token, String, desc: "This API token will be needed to get authorized."
  formats ['json']
  error code: 403, desc: "Unauthorized"
  def index
  end

end