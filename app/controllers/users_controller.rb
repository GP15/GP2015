class UsersController < ApplicationController
  before_action :authenticate_user!

  # GET /users/:id
  def show
    @children = current_user.children.sort_by_age_name
    @reservations = current_user.reservations.includes(:child, schedule: [:partner, :klass, :city])
    @current_reservations = @reservations.upcoming.sort_by_datetime_asc
    @past_reservations = @reservations.in_the_past.sort_by_datetime_desc
    #@subscriptions = current_user.subscriptions
  end
end
