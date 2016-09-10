class NotificationMailer < BaseMandrillMailer
  default from: 'admin@geniuspass.com'

  def notify(partnership)
    merge_vars = {}
    @partnership = partnership
    mail(to: "admin@geniuspass.com", subject: "New Registration of Partner", content_type: "text/html")
  end

end
