class UsersController < ApplicationController

  before_action :authenticate_user!

  def show
    @children = current_user.children.sort_by_age_name
    @reservations = current_user.reservations
                      .includes(:child, schedule: [:partner, :klass, :city])
                      .order('schedules.starts_at ASC, schedules.ends_at ASC')
  end

end
