class StaticPagesController < ApplicationController

  def index
    if params[:mobileview].present?
      cookies[:mobile] = true
    end
    @featured_partners = Partner.all.featured_partners
    if user_signed_in?
      redirect_to current_user
    end
  end

  def faq
    @faqs = FaqGroup.all
  end

  def terms
  end

  def privacy
  end

  def partners
    @partnership = PartnershipSignUp.new

    if request.post?
      @partnership = PartnershipSignUp.new(partner_params)

      if @partnership.save
        NotificationMailer.notify(@partnership).deliver_now
        redirect_to partner_signup_path, notice: 'Thank you, we will contact you soon!'
      else
        redirect_to partner_signup_path, notice: 'Something went wrong'
      end
    end
  end

  # def invite
  # end

  # def pricing
  # end

  def partner_params
    params.require(:partnership_sign_up).permit(:city, :company_name, :website, :name, :email, :phone, :address, :comments)
  end
end
