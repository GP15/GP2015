ActionMailer::Base.smtp_settings = {
    :address   => "smtp.mandrillapp.com",
    :port      => 587,
    :user_name => "info@geniuspass.com",
    :password  => "q0_HK2rlJPjI8lwUwq2_Gg",
    :domain    => 'geniuspass.com'
  }
ActionMailer::Base.delivery_method = :smtp

MandrillMailer.configure do |config|
  config.api_key = "q0_HK2rlJPjI8lwUwq2_Gg"
end

