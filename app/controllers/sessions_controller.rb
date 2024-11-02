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
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      Current.user = user
      redirect_to workspaces_path, notice: 'Logged in successfully.'
    else
      render :new, alert: 'Invalid email or password.'
    end
  end

  def destroy
    session[:user_id] = nil
    Current.user = nil
    redirect_to login_path, notice: 'Logged out successfully.'
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
