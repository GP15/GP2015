class ReservationsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_schedule

  # GET /schedules/:schedule_id/reservations/new
  def new
    @reservations = current_user.reservations.where(schedule_id: @schedule).includes(:child)
    @children = current_user.children
                  .age_between(@schedule.klass)
                  .without(@reservations)
                  .sort_by_age_name
    @reservation = @reservations.build
  end

  # POST /schedules/:schedule_id/reservations
  def create
    @reservation = @schedule.reservations.build(child_params)
    @reservation.user_id = current_user.id

    if (@schedule.reservations.count < @schedule.quantity) && @reservation.save
      flash[:notice] = "Class reserved for #{@reservation.child.first_name}."
      redirect_to new_schedule_reservation_path(@schedule)
    elsif (@schedule.reservations.count >= @schedule.quantity)
      flash[:error] = "This class has been fully booked. Please choose another schedule."
      redirect_to new_schedule_reservation_path(@schedule)
    else
      render :new
    end
  end

  # DELETE /schedules/:schedule_id/reservations/:id
  def destroy
    @reservation = @schedule.reservations.find(params[:id])
    @reservation.destroy

    flash[:notice] = "Canceled reservation for #{@reservation.child.first_name}."
    redirect_to new_schedule_reservation_path(@schedule)
  end

  private

    def set_schedule
      @schedule = Schedule.find(params[:schedule_id])
    end

    def child_params
      params.require(:reservation).permit(:child_id)
    end
end
