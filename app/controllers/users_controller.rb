class UsersController < ApplicationController


  before_action :authenticate_user!, only: [:show, :new_referal_code, :check_referal_code]
  before_action :authenticate_admin!, only: [:destroy]

  layout false,  :only => [:new_referal_code, :check_referal_code]


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

  # GET    /users/new_referal_code
  def new_referal_code
    @user = current_user
  end

  #POST   /users/check_referal_code
  def check_referal_code
    @user = current_user
    unless @user.update( promo_code_params)
      render :action => :new_referal_code
    end
  end

  private

    def promo_code_params
      params.require( :user).permit( :referal_code).merge( :being_referred => true)
    end

    def set_user
      @user = current_user
    end
end
