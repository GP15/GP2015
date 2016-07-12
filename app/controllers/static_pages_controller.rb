class StaticPagesController < ApplicationController

  def index
    @featured_partners = Partner.all.featured_partners
    if user_signed_in?
      redirect_to current_user
    end
  end

  def faq
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
