# frozen_string_literal: true

require "test_helper"

Capybara.configure do |config|
  config.server_host = "0.0.0.0"
  config.server_port = 31_337
  config.app_host = "http://#{ENV.fetch('HOSTNAME')}:#{config.server_port}"
  config.always_include_port = true
end

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome,
                       screen_size: [1400, 1400], options: {
                         browser: :remote,
                         url: "http://selenium:4444",
                         timeout: 120
                       }

  def sign_in_as(user)
    visit sign_in_url
    fill_in :email, with: user.email
    fill_in :password, with: "Secret1*3*5*"
    click_on "Login to your account"

    @current_user = user
    user
  end

  attr_reader :current_user

  def teardown
    super
    @current_user = nil
  end
end
