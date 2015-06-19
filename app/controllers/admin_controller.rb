class AdminController < ApplicationController

  before_action :authenticate_admin!

  # GET /admin
  def index
    @cities     = City.order(:name)
    @activities = Activity.order(:name)
    @partners   = Partner.order(:company)
  end

  # GET /admin/partners/:id
  def partner
    @partner = Partner.find(params[:id])
    @klasses = Klass.includes(:activity).where(partner_id: @partner.id)
                    .order(:name, :age_start, :age_end)
    @schedules = Schedule.includes(:klass).where(partner_id: @partner.id)
                         .order(:date, :start_time, :end_time)
  end
end
