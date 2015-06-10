class SchedulesController < ApplicationController

  def new
    @partner  = Partner.find(params[:partner_id])
    @schedule = @partner.schedules.build
    @klasses  = @partner.klasses
  end

  def edit
    @partner  = Partner.find(params[:partner_id])
    @schedule = @partner.schedules.find(params[:id])
    @klasses  = @partner.klasses
  end

  def create
    @partner  = Partner.find(params[:partner_id])
    @schedule = @partner.schedules.build(schedule_params)

    if @schedule.save
      redirect_to admin_partner_path(@partner.id), notice: 'New schedule created.'
    else
      @klasses = @partner.klasses
      render :new
    end
  end

  def update
    @partner  = Partner.find(params[:partner_id])
    @schedule = @partner.schedules.find(params[:id])

    if @schedule.update(schedule_params)
      redirect_to admin_partner_path(@partner.id), notice: 'Schedule updated.'
    else
      @klasses = @partner.klasses
      render :edit
    end
  end

  def destroy
    @partner  = Partner.find(params[:partner_id])
    @schedule = @partner.schedules.find(params[:id])
    @schedule.destroy

    redirect_to admin_partner_path(@partner.id), notice: 'Schedule deleted.'
  end

  private

    def schedule_params
      params.require(:schedule).permit(:klass_id, :date, :start_time, :end_time, :quantity)
    end
end
