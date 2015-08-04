class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @children = Child.order(birth_year: :desc)
  end
end
