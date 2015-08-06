class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @children = Child.order(birth_year: :desc)
    @reservations = current_user.reservations.includes(:child, schedule: [:partner, :klass, :city])
  end
end
