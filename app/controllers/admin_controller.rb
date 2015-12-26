class AdminController < ApplicationController

  layout 'admin'
  before_action :authenticate_admin!

  # GET /admin
  def index
    @schedules = Schedule.joins(:reservations).uniq
                         .includes(:klass, :partner, :reservations)
                         .where(archived: false)
                         .sort_by_datetime_asc
  end

  # GET /admin/partners
  def partners
    @partners = Partner.includes(:city).order(:company)
  end

  def featured
    if params[:featured].present? && params[:featured].length <= 5
      Partner.update_all( :featured => false)
      Partner.where(:id => params[:featured]).map{ |partner| partner.update_attributes( :featured => true)}
      flash[:notice] = "Featured partners added successfully."
    else
      flash[:error] = "Featured partners could not be added."
    end 
    redirect_to admin_partners_path
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

  def users
    @users = User.order(:created_at)
  end

  # GET /admin/settings
  def settings
    @cities     = City.order(:name)
    @activities = Activity.order(:name)
  end
end
