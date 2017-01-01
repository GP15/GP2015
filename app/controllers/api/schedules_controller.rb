class Api::SchedulesController < Api::BaseController

  api :GET, '/schedules', 'Show list of schedules'
  param :api_token, String, desc: "This API token will be needed to get authorized."
  formats ['json']
  error code: 403, desc: "Unauthorized"
  def index
  end

  api :GET, '/schedules/:id', 'Show details of schedule'
  param :api_token, String, desc: "This API token will be needed to get authorized."
  param :id, Integer
  error code: 403, desc: "Unauthorized"
  formats ['json']
  def show
  end

end