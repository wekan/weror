# frozen_string_literal: true

require "simplecov"
# SimpleCov.start "rails"
Rails.application.eager_load!

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "minitest/reporters"

Minitest::Reporters.use!(
  Minitest::Reporters::ProgressReporter.new(color: true),
  ENV,
  Minitest.backtrace_filter
)

module AuthenticationHelpers
  def sign_in_as(user)
    if respond_to?(:visit)
      visit sign_in_url
      fill_in :email, with: user.email
      fill_in :password, with: "Secret1*3*5*"
      click_on "Login to your account"
    elsif respond_to?(:session)
      session[:user_id] = user.id
    else
      post sign_in_url, params: { email: user.email, password: "Secret1*3*5*" }
    end
    @current_user = user
  end

  def current_user
    @current_user
  end

  def teardown
    super if defined?(super)
    @current_user = nil
    session[:user_id] = nil if respond_to?(:session)
  end
end

module ActiveSupport
  class TestCase
    include AuthenticationHelpers
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Fix simplecov failing when run in parallel.
    # https://github.com/simplecov-ruby/simplecov/issues/718
    # If it still has problems then disable parallelize.
    # parallelize_setup do |worker|
    #   SimpleCov.command_name "#{SimpleCov.command_name}-#{worker}"
    # end
    #
    # parallelize_teardown do |_worker|
    #   SimpleCov.result
    # end

    # Activate FactoryBot methods
    include FactoryBot::Syntax::Methods

    # Add more helper methods to be used by all tests here...

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

class ActionDispatch::IntegrationTest
  include AuthenticationHelpers

  # remove_method :teardown if method_defined?(:teardown)
  remove_method :sign_in_as if method_defined?(:sign_in_as)
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :minitest
    with.library :rails
  end
end
