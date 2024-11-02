# frozen_string_literal: true

module AuthenticationHelpers
  def sign_in_as(user)
    if respond_to?(:visit)
      visit sign_in_url
      fill_in :email, with: user.email
      fill_in :password, with: "Secret1*3*5*"
      click_on "Login to your account"
    elsif defined?(controller) && controller.respond_to?(:session)
      controller.session[:user_id] = user.id
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
