class ReservationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.auto_update.partner_update.subject
  #
  def cancelation(reservation)
    @reservation = reservation
    mail to: reservation.user.email
  end
end
