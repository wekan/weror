# frozen_string_literal: true

require "simplecov"
# SimpleCov.start "rails"
Rails.application.eager_load!

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "minitest/reporters"
require_relative "support/authentication_helpers"

Minitest::Reporters.use!(
  Minitest::Reporters::ProgressReporter.new(color: true),
  ENV,
  Minitest.backtrace_filter
)

module ActiveSupport
  class TestCase
    include AuthenticationHelpers
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Activate FactoryBot methods
    include FactoryBot::Syntax::Methods

    # Pundit helpers
    def assert_permit(user, record, action)
      msg = "User #{user.inspect} should be permitted to #{action} #{record}, but isn't permitted"
      assert permit(user, record, action), msg
    end

    def refute_permit(user, record, action)
      msg = "User #{user.inspect} should NOT be permitted to #{action} #{record}, but is permitted"
      assert_not permit(user, record, action), msg
    end

    def permit(user, record, action)
      index = self.class.name.index("Policy")
      klass = self.class.name[0, index + 6]
      klass.constantize.new(user, record).public_send("#{action}?")
    end
  end
end

class ActionController::TestCase
  include Devise::Test::IntegrationHelpers if defined?(Devise)
  include AuthenticationHelpers

  # Add session support
  def setup
    @request ||= ActionController::TestRequest.create(self.class)
  end
end

class ActionDispatch::IntegrationTest
  include AuthenticationHelpers
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :minitest
    with.library :rails
  end
end
