# frozen_string_literal: true

module AuthenticationHelpers
  def sign_in_as(user)
    if respond_to?(:session)
      session[:current_user_id] = user.id
    elsif respond_to?(:post)
      # For integration tests
      post sign_in_path, params: {
        email: user.email,
        password: user.password
      }
    end
    user
  end

  def sign_out
    if respond_to?(:session)
      session.delete(:current_user_id)
    elsif respond_to?(:delete)
      delete sign_out_path
    end
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
