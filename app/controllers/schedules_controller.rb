class SchedulesController < ApplicationController
  layout 'admin', except: [:index, :show]

  before_action :authenticate_admin!, except: [:index, :show]

  # GET /schedules
  def index
    @activities = Activity.order(:name)
    @cities     = City.order(:name)
    @q          = Schedule.ransack(params[:q])
    @q.sorts    = ['date asc', 'start_time asc', 'end_time asc'] if @q.sorts.empty?
    @schedules  = @q.result.includes(:klass, :partner, :city).where('date >= ?', Time.zone.today)
  end

  # GET /schedules/:id
  def show
    @schedule = Schedule.find(params[:id])
  end

  # GET /partners/:id/schedules/new
  def new
    @partner  = Partner.find(params[:partner_id])
    @schedule = @partner.schedules.build
    @klasses  = @partner.klasses
  end

  # GET /partners/:id/schedules/:id/edit
  def edit
    @partner  = Partner.find(params[:partner_id])
    @schedule = @partner.schedules.find(params[:id])
    @klasses  = @partner.klasses
  end

  # POST /partners/:id/schedules
  def create
    @partner  = Partner.find(params[:partner_id])
    @schedule = @partner.schedules.build(schedule_params)
    @klass    = Klass.find(schedule_params[:klass_id])
    @schedule.activity_id = @klass.activity_id

    if @schedule.save
      redirect_to admin_partner_path(@partner.id), notice: 'New schedule created.'
    else
      @klasses = @partner.klasses
      render :new
    end
  end

  # PATCH /partners/:id/schedules/:id
  def update
    @partner  = Partner.find(params[:partner_id])
    @schedule = @partner.schedules.find(params[:id])
    @klass    = Klass.find(schedule_params[:klass_id])
    @schedule.activity_id = @klass.activity_id

    if @schedule.update(schedule_params)
      redirect_to admin_partner_path(@partner.id), notice: 'Schedule updated.'
    else
      @klasses = @partner.klasses
      render :edit
    end
  end

  # DELETE /partners/:id/schedules/:id
  def destroy
    @partner  = Partner.find(params[:partner_id])
    @schedule = @partner.schedules.find(params[:id])
    @schedule.destroy

    redirect_to admin_partner_path(@partner.id), notice: 'Schedule deleted.'
  end

  private

    def schedule_params
      params.require(:schedule).permit(:starts_at, :ends_at, :quantity, :klass_id, :city_id)
    end
end
