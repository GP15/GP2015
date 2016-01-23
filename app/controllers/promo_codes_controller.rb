class PromoCodesController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  before_action :set_promo_code, only: [:show, :edit, :update, :destroy]

  # GET /promo_codes
  def index
    @promo_codes = PromoCode.all
  end

  # GET /promo_codes/1
  def show
  end

  # GET /promo_codes/new
  def new
    @promo_code = PromoCode.new
  end

  # GET /promo_codes/1/edit
  def edit
  end

  # POST /promo_codes
  def create
    @promo_code = PromoCode.new(promo_code_params)

    if @promo_code.save
      redirect_to @promo_code, notice: 'Promo code was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /promo_codes/1
  def update
    if @promo_code.update(promo_code_params)
      redirect_to @promo_code, notice: 'Promo code was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /promo_codes/1
  def destroy
    @promo_code.destroy
    redirect_to promo_codes_url, notice: 'Promo code was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_promo_code
      @promo_code = PromoCode.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def promo_code_params
      params.require(:promo_code).permit(:code, :name)
    end
end
