Braintree::Configuration.environment = :sandbox
Braintree::Configuration.merchant_id = Rails.application.secrets.merchant_id
Braintree::Configuration.public_key = Rails.application.secrets.public_key
Braintree::Configuration.private_key = Rails.application.secrets.private_key
