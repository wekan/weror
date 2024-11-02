# frozen_string_literal: true

module AuthenticationHelpers
  def sign_in_as(user)
    if respond_to?(:post)
      # Integration test
      post sign_in_url, params: {
        email: user.email,
        password: user.password
      }
    else
      # Controller test
      @request.session[:user_id] = user.id
    end
    user
  end

  def sign_out
    if respond_to?(:delete)
      # Integration test
      delete sign_out_url
    else
      # Controller test
      @request.session[:user_id] = nil
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
