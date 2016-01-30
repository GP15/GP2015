class AutoUpdate < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.auto_update.partner_update.subject
  #
  def partner_update(schedule)
    @greeting = "Hi"
    @schedule = schedule
    mail to: schedule.klass.partner.email
  end
end
