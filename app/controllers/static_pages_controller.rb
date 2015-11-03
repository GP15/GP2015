class StaticPagesController < ApplicationController

  def index
    if user_signed_in?
      redirect_to current_user
    end
  end

  def terms
  end

  def privacy
  end

  # def invite
  # end

  # def pricing
  # end
end
