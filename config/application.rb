require_relative 'boot'

require 'rails/all'
require 'action_view/component'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Books
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.app_name = 'Books'
    config.action_view_component.preview_path = "#{Rails.root}/spec/components/previews"
    config.active_model.i18n_customize_full_message = true

    config.x.search.num_of_pages_upper = 500
  end
end
