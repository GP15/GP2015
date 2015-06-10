class AdminController < ApplicationController

  def index
    @cities     = City.all
    @activities = Activity.all
    @partners   = Partner.all
  end

  def partner
    @partner = Partner.find(params[:id])
    @klasses = Klass.includes(:activity).where(partner_id: @partner.id)
    @schedules = Schedule.includes(:klass).where(partner_id: @partner.id)
  end

end
