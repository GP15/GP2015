class AdminController < ApplicationController

  before_action :authenticate_admin!

  # GET /admin
  def index
    @schedules = Schedule.joins(:reservations).uniq
                         .includes(:klass, :partner, :reservations)
                         .sort_by_datetime_asc
  end

  # GET /admin/partners
  def partners
    @partners = Partner.includes(:city).order(:company)
  end

  # GET /admin/partners/:id
  def partner
    @partner = Partner.find(params[:id])
    @schedules = @partner.schedules.includes(:klass, :reservations).recent.sort_by_datetime_asc
  end

  # GET /admin/partners/:id/past_schedules
  def past_schedules
    @partner = Partner.find(params[:id])
    @schedules = @partner.schedules.includes(:klass, :reservations).in_the_past.sort_by_datetime_desc
  end

  # GET /admin/partners/:id/klasses
  def klasses
    @partner = Partner.find(params[:id])
    @klasses = @partner.klasses.includes(:activity).order(:age_start, :age_end, :name)
  end

  # GET admin/schedules/:id
  def schedule
    @schedule = Schedule.find(params[:id])
    @partner  = @schedule.partner
    @reservations = @schedule.reservations.includes(:child)
  end

  # GET /admin/settings
  def settings
    @cities     = City.order(:name)
    @activities = Activity.order(:name)
  end
end
