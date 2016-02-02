source 'https://rubygems.org'
ruby '2.2.2'
gem 'braintree'
gem 'rails',        '4.2.4'
gem 'pg'
gem 'sass-rails',   '~> 5.0'
gem 'uglifier',     '>= 1.3.0'      # JavaScript assets compressor
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'devise',       '~> 3.5.1'      # user authentication
gem 'ransack',      '~> 1.6.6'      # search/filter ActiveRecords
gem 'faker',        '~> 1.5.0'      # generate fake data, useful for db seeds
gem 'tabulous',     '~> 2.1.3'      # create tabbed navigation bar
gem 'validates_overlap', '~> 0.5.2' # check for overlapping time records
gem 'simple_form'
gem 'haml-rails'
gem 'mandrill_mailer'               # Provides mailing functionality.
gem 'carrierwave'                   # Upload images
gem 'rmagick'                       # Supports cropping of images
gem 'geocoder'
gem 'gmaps4rails'
gem 'underscore-rails'
gem 'has_secure_token'
gem 'sidekiq'

group :doc do
  gem 'sdoc', '~> 0.4.0'            # bundle exec rake doc:rails generates the API under doc/api.
end

group :development, :test do
  gem 'byebug'                    # access debugger console by calling it in code
  gem 'web-console', '~> 2.0'     # access IRB console on exception pages
  gem 'spring'                    # speeds development by running app in background
  gem 'hirb'                      # Pretty rails console output. Enable in console using "Hirb.enable".
  gem 'quiet_assets', '~> 1.1.0'  # turns off asset pipeline log
  gem 'bullet',       '~> 4.14.7' # check for N+1 queries and unused eager loading
end

group :production do
                                # deploying to Heroku requires these 2 gems:
  gem 'rails_12factor'          # output logs to stdout for 3rd party log apps
  gem 'puma'                    # webserver recommended by Heroku
end
