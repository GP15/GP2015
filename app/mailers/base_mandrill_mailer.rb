require "mandrill"

class BaseMandrillMailer < ActionMailer::Base
  default(
    from: "info@geniuspass.com",
    reply_to: "info@geniuspass.com"
  )

  private

  def send_mail(email, subject, body)
    mail(to: email, subject: subject, body: body, content_type: "text/html")
  end

  def mandrill_template(template_name, attributes)
    mandrill = Mandrill::API.new("q0_HK2rlJPjI8lwUwq2_Gg")

    merge_vars = attributes.map do |key, value|
      { name: key, content: value }
    end

    mandrill.templates.render(template_name, [], merge_vars)["html"]
  end
end
