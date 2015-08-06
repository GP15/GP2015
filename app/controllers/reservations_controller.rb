class ReservationsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_schedule

  # GET /schedules/:schedule_id/reservations/new
  def new
    @children = current_user.children
    @reservation = @schedule.reservations.build
  end

  # POST /schedules/:schedule_id/reservations
  def create
    @reservation = @schedule.reservations.build(child_params)
    @reservation.user_id = current_user.id

    if @reservation.save
      redirect_to current_user, notice: "Reserved a class on #{@schedule.date}."
    else
      render :new
    end
  end

  # DELETE
  def destroy
    @child = @user.children.find(params[:id])
    @child.destroy

    redirect_to current_user, notice: "#{@child.first_name} deleted."
  end

  private

    def set_schedule
      @schedule = Schedule.find(params[:schedule_id])
    end

    def child_params
      params.require(:reservation).permit(:child_id)
    end
end
