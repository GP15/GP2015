Apipie.configure do |config|
  config.app_name                = "Geniuspass"
  config.api_base_url            = "/api"
  config.doc_base_url            = "/gs-api"
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
  config.authenticate = Proc.new do
     authenticate_or_request_with_http_basic do |username, password|
       username == "geniuspass" && password == "geniuspass"
    end
  end
end
