class ReservationsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_schedule
  before_action :set_reservations
  before_action :set_children

  # GET /schedules/:schedule_id/reservations/new
  def new
    @reservations = current_user.reservations.eager_load(:schedule, :child).where(schedule_id: @schedule)
    @children = current_user.children
                  .valid_children_wrt_subscriptions(current_user)
                  .age_between(@schedule.klass)
                  .without(@reservations)
                  .sort_by_age_name
    @reservation = @reservations.build
  end

  # POST /schedules/:schedule_id/reservations
  def create
    @reservation = @schedule.reservations.build(child_params)
    @reservation.user_id = current_user.id
    puts current_user.can_make_reservation_for_partner?(@schedule.partner).inspect
    puts "----------------------------------------------------------------------"
    if current_user.can_make_reservation_for_partner?(@schedule.partner)
      if (@schedule.reservations.count < @schedule.quantity) && @reservation.save
        flash[:notice] = "Class reserved for #{@reservation.child.fullname}."
        redirect_to new_schedule_reservation_path(@schedule, convert: true)
      elsif (@schedule.reservations.count >= @schedule.quantity)
        flash[:error] = "This class has been fully booked. Please choose another schedule."
        redirect_to new_schedule_reservation_path(@schedule)
      else
        render :new
      end
    else
      # flash[:error] = "#{@reservation.child.fullname} quota limit for #{@schedule.partner.company} has been reached."
      flash[:error] = "Quota limit for #{@schedule.partner.company} has been reached."
      redirect_to new_schedule_reservation_path(@schedule)
    end
  end

  # DELETE /schedules/:schedule_id/reservations/:id
  def destroy
    @reservation = @schedule.reservations.find(params[:id])
    if @reservation.cancel_reservation?
      redirect_to new_schedule_reservation_path(@schedule), notice: "Canceled reservation for #{@reservation.child.fullname}."
    else
      redirect_to new_schedule_reservation_path(@schedule), notice: "Sorry could not cancell your reservation, Please try again."
    end
  end

  private

    def set_schedule
      @schedule = Schedule.find(params[:schedule_id])
    end

    def set_reservations
      @reservations = current_user.reservations.where(schedule_id: @schedule).includes(:child)
    end

    def set_children
      @children = current_user.children.age_between(@schedule.klass)
                                       .without(@reservations)
                                       .sort_by_age_name
    end

    def child_params
      params.require(:reservation).permit(:child_id)
    end
end
