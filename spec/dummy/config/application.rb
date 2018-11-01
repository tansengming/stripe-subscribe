require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)
require "stripe/subscribe"

module Dummy
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.stripe.secret_key = 'sk_test_XXXXXXXXXXXXXXXX'
    config.stripe.publishable_key = 'pk_test_XXXXXXXXXXXXXXXXXX'

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end

