class CitiesController < ApplicationController
  layout 'admin'

  before_action :authenticate_admin!
  before_action :set_city, only: [:edit, :update, :destroy]

  # GET /city/new
  def new
    @city = City.new
  end

  # GET /city/:id/edit
  def edit
  end

  # POST /city
  def create
    @city = City.new(city_params)

    if @city.save
      redirect_to admin_settings_path, notice: 'City created.'
    else
      render :new
    end
  end

  # PATCH /city/:id
  def update
    if @city.update(city_params)
      redirect_to admin_settings_path, notice: 'City updated.'
    else
      render :edit
    end
  end

  # DELETE /city/:id
  def destroy
    @city.destroy
    redirect_to admin_settings_path, notice: 'City deleted.'
  end

  private

    def set_city
      @city = City.find(params[:id])
    end

    def city_params
      params.require(:city).permit(:name)
    end
end
