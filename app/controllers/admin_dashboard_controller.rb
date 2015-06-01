class AdminDashboardController < ApplicationController

  def index
    @cities   = City.all
    @partners = Partner.all
  end

end
