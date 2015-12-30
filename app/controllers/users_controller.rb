class UsersController < ApplicationController


  before_action :authenticate_user!, only: [:show]
  before_action :authenticate_admin!, only: [:destroy]


  # GET /users/:id
  def show
    @reservations = current_user.reservations.includes(:child, schedule: [:partner, :klass, :city])
    @current_reservations = @reservations.upcoming.sort_by_datetime_asc
    @past_reservations = @reservations.in_the_past.sort_by_datetime_desc
    #@subscriptions = current_user.subscriptions
  end

  # DELETE /users/:id
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to admin_users_path, notice: "User deleted."
  end


  def promo_code
    if current_user.promo_code.nil?
      current_user.promo_code = current_user.generate_promo_code
      current_user.save
    end
    redirect_to current_user
  end

end
