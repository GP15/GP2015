class UsersController < ApplicationController

  before_action :authenticate_user!

  def show
    @children = current_user.children
    @reservations = current_user.reservations.includes(:child, schedule: [:partner, :klass, :city])
  end

end
