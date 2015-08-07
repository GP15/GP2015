class AdminController < ApplicationController

  before_action :authenticate_admin!

  # GET /admin
  def index
    @partners   = Partner.includes(:city).order(:company)
  end

  # GET /admin/partners/:id
  def partner
    @partner = Partner.find(params[:id])
    @klasses = @partner.klasses.includes(:activity).order(:name, :age_start, :age_end)
    @schedules = @partner.schedules.includes(:klass).sort_by_datetime_asc
  end

  def settings
    @cities     = City.order(:name)
    @activities = Activity.order(:name)
  end
end
