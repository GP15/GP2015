class PartnersController < ApplicationController
  layout 'admin', except: [:index, :show]

  before_action :authenticate_admin!, except: [:index, :show, :loadmore]
  before_action :set_partner, only: [:show, :edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html do
        if params[:lat].present? && params[:lng].present?
          distance = 20
          center_point = [params[:lat], params[:lng]]
          box = Geocoder::Calculations.bounding_box(center_point, distance)
          @partners = Partner.within_bounding_box(box)
                             .joins("left join klasses on klasses.partner_id = partners.id")
                             .select("partners.*, max(klasses.reservation_limit) as booking_limit")
                             .includes(:city, :activities)
                             .group(:id)
                             .order(:company).limit(6)
        else
          @partners = Partner.joins("left join klasses on klasses.partner_id = partners.id")
                             .select("partners.*, max(klasses.reservation_limit) as booking_limit")
                             .includes(:city, :activities)
                             .group(:id)
                             .order(:company).limit(6)
        end
      end

      format.json do
        @partners = Partner.where.not(latitude: nil, longitude: nil).select(:latitude, :longitude)
      end
    end
  end

  def loadmore
    if params[:lat].present? && params[:lng].present?
      distance = 20
      center_point = [params[:lat], params[:lng]]
      box = Geocoder::Calculations.bounding_box(center_point, distance)
      @partners = Partner.within_bounding_box(box)
                         .joins("left join klasses on klasses.partner_id = partners.id")
                         .select("partners.*, max(klasses.reservation_limit) as booking_limit")
                         .includes(:city, :activities)
                         .group("partners.id")
                         .order(:company).paginate(page: params[:page], per_page: 6)
    else
      @partners = Partner.joins("left join klasses on klasses.partner_id = partners.id")
                         .select("partners.*, max(klasses.reservation_limit) as booking_limit")
                         .includes(:city, :activities)
                         .group("partners.id")
                         .order(:company).paginate(page: params[:page], per_page: 6)
    end
    render layout: false
  end

  def show
    @klasses   = @partner.klasses.order(:name)
    @schedules = @partner.schedules.not_archived
                         .includes(:klass)
                         .six_hours_from_now
                         .sort_by_datetime_asc
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
      @partner.schedules.update_all(city_id: @partner.city_id)
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
      params.require(:partner).permit(:company, :phone, :address, :state, :email,
                    :city_id, :img_url, :logo, :latitude, :longitude, :user_allowed)
    end
end
