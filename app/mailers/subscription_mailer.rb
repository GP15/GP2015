class SubscriptionMailer < BaseMandrillMailer
  default from: 'info@geniuspass.com'

  def invite(user)
    subject = "You are subscribed"
    merge_vars = {}
    body = mandrill_template("subscribe_to_geniuspass", merge_vars)

    send_mail(user.email, subject, body)
  end
end
