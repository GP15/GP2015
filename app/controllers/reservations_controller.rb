class ReservationsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_schedule

  # GET /schedules/:schedule_id/reservations/new
  def new
    @children = current_user.children.sort_by_age_name
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

  # DELETE /schedules/:schedule_id/reservations/:id
  def destroy
    @reservation = @schedule.reservations.find(params[:id])
    @reservation.destroy

    redirect_to current_user, notice: "Reservation for class #{@schedule.klass.name} on #{@schedule.date} for #{@reservation.child.first_name} canceled."
  end

  private

    def set_schedule
      @schedule = Schedule.find(params[:schedule_id])
    end

    def child_params
      params.require(:reservation).permit(:child_id)
    end
end
