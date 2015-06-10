class AdminController < ApplicationController

  # GET /admin
  def index
    @cities     = City.all
    @activities = Activity.all
    @partners   = Partner.all
  end

  # GET /admin/partners/:id
  def partner
    @partner = Partner.find(params[:id])
    @klasses = Klass.includes(:activity).where(partner_id: @partner.id)
    @schedules = Schedule.includes(:klass).where(partner_id: @partner.id)
  end

end
