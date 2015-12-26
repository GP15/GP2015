Braintree::Configuration.environment = Rails.env.production? ? :production : :sandbox
Braintree::Configuration.logger = Logger.new('log/braintree.log')
Braintree::Configuration.merchant_id = Rails.application.secrets.merchant_id
Braintree::Configuration.public_key = Rails.application.secrets.public_key
Braintree::Configuration.private_key = Rails.application.secrets.private_key
