# frozen_string_literal: true

require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# Translations https://guides.rubyonrails.org/i18n.html
config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,json}')]
config.i18n.default_locale = :en
# Permitted locales available for the application
#I18n.available_locales = [:en, :pt]


module ICanHasKanban
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w(assets tasks))

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Allow Rubocop to autocorrect generated files
    config.generators.after_generate do |files|
      parsable_files = files.filter { |file| file.end_with?(".rb") }
      unless parsable_files.empty?
        system("bundle exec rubocop -A --fail-level=E #{parsable_files.shelljoin}", exception: true)
      end
    end
  end
end
