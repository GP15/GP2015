class WelcomeMailer < BaseMandrillMailer
  default from: 'info@geniuspass.com'

  def invite(user)
    subject = "Welcome to GeniusPass"
    merge_vars = {}
    body = mandrill_template("welcome_to_geniuspass", merge_vars)

    send_mail(user.email, subject, body)
  end
end
