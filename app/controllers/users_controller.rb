class UsersController < ApplicationController


  before_action :authenticate_user!, only: [:show, :new_referal_code, :check_referal_code, :onboard, :add_child]
  before_action :set_user, only: [:onboard, :add_child]
  before_action :authenticate_admin!, only: [:destroy]

  layout false,  :only => [:new_referal_code, :check_referal_code]


  # GET /users/:id
  def show
    @child_id = params[:child_id]
    if @child_id.blank?
      @child_id = current_user.children.first.id if current_user.children.present?
    end
    @child = Child.find_by_id(@child_id)

    @reservations = current_user.reservations.child(@child_id).includes(:child, schedule: [:partner, :klass, :city])
    @current_reservations = @reservations.child(@child_id).upcoming.sort_by_datetime_asc
    @past_reservations = @reservations.child(@child_id).in_the_past.sort_by_datetime_desc
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

  def add_child
    @user.attributes = add_child_params
    if @user.save
      puts @user.errors.inspect
      render json: { success: true, child_id: @user.children.last.id }
    else
      puts @user.errors.inspect
      render json: { error: true, message: "Please complete all the details." }
    end
  end

  def onboard
    @user.children.build
    @questions = (Question.left_brain.sample(5) + Question.right_brain.sample(5)).sample(10)
  end

  private

  def promo_code_params
    params.require( :user).permit( :referal_code).merge( :being_referred => true)
  end

  def set_user
    @user = current_user
  end

  def add_child_params
    params.require(:user).permit(children_attributes: [:id, :fullname, :first_name, :last_name, :birth_year, :user_id, :gender, :_destroy])
  end
end
