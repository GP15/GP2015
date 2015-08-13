class SchedulesController < ApplicationController

  layout 'admin', except: [:index, :show]

  before_action :authenticate_admin!, except: [:index, :show]
  before_action :set_partner,         except: [:index, :show]
  before_action :set_schedule,        only:   [:edit, :update, :destroy]
  before_action :set_klass,           only:   [:create, :update]

  # GET /schedules
  def index
    @activities = Activity.order(:name)
    @cities     = City.order(:name)
    @q          = Schedule.ransack(params[:q])
    @q.sorts    = ['date asc', 'start_time asc', 'end_time asc'] if @q.sorts.empty?
    @schedules  = @q.result.includes(:klass, :partner, :city).where('starts_at >= ?', Time.zone.today)
  end

  # GET /schedules/:id
  def show
    @schedule = Schedule.find(params[:id])
  end

  # GET /partners/:id/schedules/new
  def new
    @schedule = @partner.schedules.build
    @klasses  = @partner.klasses
  end

  # GET /partners/:id/schedules/:id/edit
  def edit
    @klasses = @partner.klasses
  end

  # POST /partners/:id/schedules
  def create
    @schedule = @partner.schedules.build(
      activity_id: @klass.activity_id,
      city_id:     @partner.city_id,
      klass_id:    schedule_params[:klass_id],
      quantity:    schedule_params[:quantity],
      starts_at:   start_datetime,
      ends_at:     end_datetime
    )

    if @schedule.save
      redirect_to admin_partner_path(@partner.id), notice: 'New schedule created.'
    else
      @klasses = @partner.klasses
      render :new
    end
  end

  # PATCH /partners/:id/schedules/:id
  def update
    @schedule.activity_id = @klass.activity_id
    @schedule.city_id     = @partner.city_id
    @schedule.klass_id    = schedule_params[:klass_id]
    @schedule.quantity    = schedule_params[:quantity]
    @schedule.starts_at   = start_datetime
    @schedule.ends_at     = end_datetime

    if @schedule.save
      redirect_to admin_partner_path(@partner.id), notice: 'Schedule updated.'
    else
      @klasses = @partner.klasses
      render :edit
    end
  end

  # DELETE /partners/:id/schedules/:id
  def destroy
    @schedule.destroy
    redirect_to admin_partner_path(@partner.id), notice: 'Schedule deleted.'
  end

  private

    def schedule_params
      params.require(:schedule).permit(:klass_id, :starts_at, :ends_at, :quantity)
    end

    def set_partner
      @partner = Partner.find(params[:partner_id])
    end

    def set_schedule
      @schedule = @partner.schedules.find(params[:id])
    end

    def set_klass
      @klass = Klass.find(schedule_params[:klass_id])
    end

    # Put the value from the single date select into starts_at & ends_at attributes.

    def start_datetime # Needed so the starts_at params is not nil.
      DateTime.civil(
        schedule_params["starts_at(1i)"].to_i,
        schedule_params["starts_at(2i)"].to_i, schedule_params["starts_at(3i)"].to_i,
        schedule_params["starts_at(4i)"].to_i, schedule_params["starts_at(5i)"].to_i
      )
    end

    def end_datetime # Copies date from starts_at params.
      DateTime.civil(
        schedule_params["starts_at(1i)"].to_i,
        schedule_params["starts_at(2i)"].to_i, schedule_params["starts_at(3i)"].to_i,
        schedule_params["ends_at(4i)"].to_i, schedule_params["ends_at(5i)"].to_i
      )
    end
end
