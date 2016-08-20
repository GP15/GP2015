class SchedulesController < ApplicationController

  layout 'admin', except: [:index, :show, :curated]

  before_action :set_partner,         except: [:index, :show, :archive, :unarchive, :curated]
  before_action :set_schedule,        only:   [:edit, :update, :destroy]
  before_action :set_klass,           only:   [:create, :update]

  # GET /schedules
  def index
    @activities = Activity.order(:name)
    @cities     = City.order(:name)

    # Using Ransack to filter Activity, City, Date, Starting Time, & Ending Time for Schedules.
    # Unfortunately when left to default setting, Ransack will use today's date when filtering
    # the starting time and ending time since we're using separate select menu for date & time.
    params[:q] = {} unless params[:q]

    # Copies the date params from date select to replace the date params from the time select menu.

    date = Date.tomorrow
    date = Date.parse(params[:start_date])                     if params[:start_date].present?
    start_time = date.beginning_of_day
    end_time   = date.end_of_day
    start_time = format_datetime( date, params[ :start_time])  if params[ :start_time].present?
    end_time   = format_datetime( date, params[ :end_time])    if params[ :end_time].present?


    # byebug
    @q = Schedule.ransack(params[:q]) # Filter with Ransack
    if params[:q].present?
      @schedules =  @q.result             # Result of Ransack
    else
      # When not filtering anything aka visiting /schedules, show all schedules from tomorrow.
      @schedules = Schedule.only_tomorrow
    end

    # Final filtering
    @schedules = @schedules.not_archived
                           .includes(:klass, :partner, :city)
                           .sort_by_datetime_asc

    @schedules =  @schedules.select{|schedule|
      time_in_minutes(start_time) <= time_in_minutes(schedule.starts_at) &&
      time_in_minutes(end_time) >= time_in_minutes(schedule.starts_at)
    }

    @schedules =  @schedules.select{|schedule| schedule.klass.age_start <= params[:age].to_i && schedule.klass.age_end >= params[:age].to_i } unless params[:age].to_i == 0
    @schedules =  @schedules.select{|schedule| schedule.scheduled_dates.include?(date)}

    #@date = Date.parse(@date).strftime("%A, %d %B %Y")
  end

  def time_in_minutes(full_time)
    full_time.hour * 60 + full_time.min
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
      ends_at:     end_datetime,
      recurrence:  schedule_params[:recurrence]
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
    @schedule.recurrence  = schedule_params[:recurrence]

    if @schedule.save
      redirect_to admin_schedule_path(@schedule), notice: 'Schedule updated.'
    else
      @klasses = @partner.klasses
      render :edit
    end
  end

  # DELETE /partners/:id/schedules/:id
  def destroy
    @schedule.destroy
    redirect_to admin_partner_path(@partner), notice: 'Schedule deleted.'
  end

  # PATCH /schedules/:id/archive
  def archive
    @schedule = Schedule.find(params[:id])

    @schedule.update(archived: true)
    redirect_to admin_schedule_path(@schedule), notice: 'Schedule deactivated.'
  end

  # PATCH /schedules/:id/unarchive
  def unarchive
    @schedule = Schedule.find(params[:id])

    @schedule.update(archived: false)
    redirect_to admin_schedule_path(@schedule), notice: 'Schedule activated.'
  end

  private

    def schedule_params
      params.require(:schedule).permit(:klass_id, :starts_at, :ends_at, :quantity, :recurrence)
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
    def format_datetime( date, time)
      Time.zone.parse("#{date} #{time}")
    end

    def start_datetime # Needed so the starts_at params is not nil.
      Time.zone.local(
        schedule_params["starts_at(1i)"].to_i,
        schedule_params["starts_at(2i)"].to_i, schedule_params["starts_at(3i)"].to_i,
        schedule_params["starts_at(4i)"].to_i, schedule_params["starts_at(5i)"].to_i
      )
    end

    def end_datetime # Modify ends_at params by copying the date from starts_at params.
      Time.zone.local(
        schedule_params["starts_at(1i)"].to_i,
        schedule_params["starts_at(2i)"].to_i, schedule_params["starts_at(3i)"].to_i,
        schedule_params["ends_at(4i)"].to_i, schedule_params["ends_at(5i)"].to_i
      )
    end
end
