# frozen_string_literal: true

# Sessions Controller
class SessionsController < ApplicationController
  skip_before_action :authenticate, only: %i[new create]
  before_action :prep_demo, only: :create

  before_action :set_session, only: :destroy

  def index
    @sessions = Current.user.sessions.order(created_at: :desc)
  end

  def new; end

  def create
    # prep_demo has already given @user for the demo account, which signs in
    # with any password.
    if @user ||= User.authenticate_by(email: params[:email], password: params[:password])
      # ApplicationController#authenticate admits a request by this Session
      # record's signed cookie: without it every page after signing in
      # redirected back to sign in.
      @session = @user.sessions.create!
      cookies.signed.permanent[:session_token] = { value: @session.id, httponly: true }
      session[:user_id] = @user.id
      Current.user = @user
      redirect_to workspaces_path, notice: "Logged in successfully."
    else
      redirect_to sign_in_path(email_hint: params[:email]), notice: "That email or password is incorrect"
    end
  end

  def destroy
    @session.destroy
    session[:user_id] = nil
    Current.user = nil
    redirect_to root_path, notice: "That session has been logged out"
  end

  private
    def set_session
      @session = Current.user.sessions.find(params[:id])
    end

    def prep_demo
      if params[:email] == "user@demo.test"
        @user = DemoPrep.initialize_demo("user@demo.test")
      end
    end
end
