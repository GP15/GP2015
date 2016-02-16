class WelcomeMailer < BaseMandrillMailer
  default from: 'admin@example.com'

  def invite(user)
    subject = "Welcome to GeniusPass"
    merge_vars = {}
    body = mandrill_template("welcome_to_maildrill", merge_vars)

    send_mail(user.email, subject, body)
  end
end
