class PartnersController < ApplicationController
  layout 'admin', except: [:index, :show]

  before_action :set_partner, only: [:show, :edit, :update, :destroy]

  def index
    @partners = Partner.includes(:city, :klasses)
  end

  def show
    @schedules = Schedule.includes(:klass).where(partner_id: @partner)
                         .order(:date, :start_time, :end_time)
  end

  def new
    @partner = Partner.new
  end

  def edit
  end

  def create
    @partner = Partner.new(partner_params)

    if @partner.save
      redirect_to admin_partner_path(@partner), notice: 'Partner added.'
    else
      render :new
    end
  end

  def update
    if @partner.update(partner_params)
      redirect_to admin_partner_path(@partner), notice: 'Partner details updated.'
    else
      render :edit
    end
  end

  def destroy
    @partner.destroy
    redirect_to admin_path, notice: 'Partner deleted.'
  end

  private

    def set_partner
      @partner = Partner.find(params[:id])
    end

    def partner_params
      params.require(:partner).permit(:company, :phone, :address, :state, :city_id, :img_url)
    end
end
