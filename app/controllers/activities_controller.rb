class ActivitiesController < ApplicationController
  layout 'admin'

  before_action :authenticate_admin!
  before_action :set_activity, only: [:edit, :update, :destroy]

  # GET /activities/new/test
  def new
    @activity = Activity.new
  end

  # GET /activities/:id/edit
  def edit
  end

  # POST /activities
  def create
    @activity = Activity.new(activity_params)

    if @activity.save
      redirect_to admin_settings_path, notice: 'New activity created.'
    else
      render :new
    end
  end

  # PATCH /activities/:id
  def update
    if @activity.update(activity_params)
      redirect_to admin_settings_path, notice: 'Activity updated.'
    else
      render :edit
    end
  end

  # DELETE /activities/:id
  def destroy
    @activity.destroy
    redirect_to admin_settings_path, notice: 'Activity deleted.'
  end

  private

    def set_activity
      @activity = Activity.find(params[:id])
    end

    def activity_params
      params.require(:activity).permit(:name)
    end
end
