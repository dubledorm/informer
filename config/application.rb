require_relative "boot"

#require "rails/all"
require 'active_model/railtie'
#require "active_job/railtie"
require 'active_record/railtie'
#require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
#require "action_mailbox/engine"
#require "action_text/engine"
#require "action_view/railtie"
#require "action_cable/engine"
require 'sprockets/railtie'
#require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Informer
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.i18n.default_locale = :ru
    I18n.config.enforce_available_locales = false

    config.logger = Logger.new($stdout) if Rails.env.production?
  end
end
