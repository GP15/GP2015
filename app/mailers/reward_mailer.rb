class RewardMailer < BaseMandrillMailer
  default from: 'admin@geniuspass.com'

  def notify(user, reward)
    merge_vars = {}
    # body = mandrill_template("subscribe_to_geniuspass", merge_vars)
    @reward = reward
    @receiver = user
    mail(to: user.email, bcc: "admin@geniuspass.com", subject: "You redeemed a reward from GeniussPass", content_type: "text/html")
  end

end
