class ClassBookingMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.auto_update.partner_update.subject
  #
  def notification(reservation)
    @greeting = "Hi"
    @reservation = reservation
    mail to: reservation.user.email
  end
end
