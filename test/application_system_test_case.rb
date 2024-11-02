# frozen_string_literal: true

require "test_helper"

Capybara.configure do |config|
  config.server_host = "0.0.0.0"
  config.server_port = 31_337
  config.app_host = "http://#{ENV.fetch('HOSTNAME')}:#{config.server_port}"
  config.always_include_port = true
end

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include AuthenticationHelpers

  driven_by :selenium, using: :chrome,
                       screen_size: [1400, 1400], options: {
                         browser: :remote,
                         url: "http://selenium:4444",
                         timeout: 120
                       }
end
