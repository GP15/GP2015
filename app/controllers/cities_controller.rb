class CitiesController < ApplicationController
  layout 'admin'

  before_action :set_city, only: [:show, :edit, :update, :destroy]

  def index
    @cities = City.all
  end

  def show
  end

  def new
    @city = City.new
  end

  def edit
  end

  def create
    @city = City.new(city_params)

    if @city.save
      redirect_to admin_path, notice: 'City created.'
    else
      render :new
    end
  end

  def update
    if @city.update(city_params)
      redirect_to admin_path, notice: 'City updated.'
    else
      render :edit
    end
  end

  def destroy
    @city.destroy
    redirect_to admin_path, notice: 'City deleted.'
  end

  private

    def set_city
      @city = City.find(params[:id])
    end

    def city_params
      params.require(:city).permit(:name)
    end
end
