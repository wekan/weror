# frozen_string_literal: true

# Base Application Controller
class ApplicationController < ActionController::Base
  before_action :set_current_request_details
  before_action :authenticate
  before_action :set_locale
  before_action :set_current_user
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def update_locale
    I18n.locale = params[:locale] || I18n.default_locale
    redirect_back(fallback_location: root_path)
  end

  private
    def authenticate
      if (session_record = Session.find_by(id: cookies.signed[:session_token]))
        Current.session = session_record
      else
        redirect_to sign_in_path
      end
    end

    def set_current_request_details
      Current.user_agent = request.user_agent
      Current.ip_address = request.ip
    end

    def pundit_user
      Current.user
    end

    def user_not_authorized
      flash.now[:notice] = "You are not authorized to perform this action."
    end

    def set_locale
      I18n.locale = session[:locale] || I18n.default_locale
    end

    def set_current_user
      Current.user = User.find_by(id: session[:user_id])
    end

    def current_user
      @current_user ||= User.find(session[:user_id])
    rescue ActiveRecord::RecordNotFound
      nil
    end

    def authenticate_user!
      unless current_user
        redirect_to login_path, alert: "Please log in to continue."
      end
    end
end
