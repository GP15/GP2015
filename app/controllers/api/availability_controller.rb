
class Api::AvailabilityController < Api::BaseController

  api :POST, ' /children/:child_id/availability', 'Create availability for child'
  param :api_token, String, desc: "This API token will be needed to get authorized."
  param :child_id, Integer, desc: "Child's id"
  param :availability, Hash, desc: "Availability info" do
    param :start_time,  String, desc: "Availability's start time",  required: true
    param :end_time,    String, desc: "Availability's end time",    required: true
    param :day, ["monday","tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"], desc: "Availability's day"
  end
  error code: 403, desc: "Unauthorized"
  formats ['json']
  def create
  end

  api :PATCH, ' /children/:child_id/availability/:id', 'Update availability for child'
  param :api_token, String, desc: "This API token will be needed to get authorized."
  param :id, Integer, desc: "Availability's id"
  param :child_id, Integer, desc: "Child's id"
  param :availability, Hash, desc: "Availability info" do
    param :start_time,  String, desc: "Availability's start time",  required: true
    param :end_time,    String, desc: "Availability's end time",    required: true
    param :day, ["monday","tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"], desc: "Availability's day"
  end
  error code: 403, desc: "Unauthorized"
  formats ['json']
  def update
  end

end