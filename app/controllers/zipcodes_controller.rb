class ZipcodesController < ApplicationController
  before_action :set_zipcode, only: [:show, :edit, :update, :destroy]
  layout 'admin'

  def contact_request
    zip_code = params[:zipcode]
    zipcode = Zipcode.active.find_by_pincode zip_code
    ContactRequest.create(email: params[:email], zipcode: params[:zipcode])
    if zipcode
      session[:email]   = params[:email]
      session[:zipcode] = params[:zipcode]
      redirect_to new_user_registration_path
    else
      redirect_to root_path(soon: true)
    end
  end

  # GET /zipcodes
  def index
    @zipcodes = Zipcode.all
  end

  # GET /zipcodes/1
  def show
    redirect_to zipcodes_path
  end

  # GET /zipcodes/new
  def new
    @zipcode = Zipcode.new
  end

  # GET /zipcodes/1/edit
  def edit
  end

  # POST /zipcodes
  def create
    @zipcode = Zipcode.new(zipcode_params)

    if @zipcode.save
      redirect_to @zipcode, notice: 'Zipcode was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /zipcodes/1
  def update
    if @zipcode.update(zipcode_params)
      redirect_to @zipcode, notice: 'Zipcode was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /zipcodes/1
  def destroy
    @zipcode.destroy
    redirect_to zipcodes_url, notice: 'Zipcode was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_zipcode
      @zipcode = Zipcode.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def zipcode_params
      params.require(:zipcode).permit(:pincode)
    end
end
