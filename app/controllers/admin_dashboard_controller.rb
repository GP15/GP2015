class AdminDashboardController < ApplicationController

  def index
    @cities     = City.all
    @categories = Category.all
    @partners   = Partner.all
  end

end
