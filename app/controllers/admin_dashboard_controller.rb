class AdminDashboardController < ApplicationController

  def index
    @cities     = City.all
    @activities = Activity.all
    @partners   = Partner.all
  end

end
