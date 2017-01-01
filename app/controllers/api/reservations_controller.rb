class Api::ReservationsController < Api::BaseController

  api :GET, '/children/:child_id/reservations', 'Create new reservation for child'
  param :api_token, String, desc: "This API token will be needed to get authorized."
  param :child_id, Integer, required: true
  param :reservation, Hash, desc: "Reservation info" do
    param :schedule_id, Integer, desc: "Schedule's Id", required: true
    param :child_id, Integer, desc: "Child's Id", required: true
    param :user_id, Integer, desc: "User's Id", required: true
  end
  error code: 403, desc: "Unauthorized"
  formats ['json']
  def create
  end

  api :GET, '/children/:child_id/reservations', 'View Child Reservations'
  param :api_token, String, desc: "This API token will be needed to get authorized."
  param :child_id, Integer
  formats ['json']
  error code: 403, desc: "Unauthorized"
  def index
  end
end