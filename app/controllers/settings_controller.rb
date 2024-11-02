# frozen_string_literal: true

# Settings Controller
class SettingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @language = current_user.language
  end

  private

  def change_locale
    if I18n.available_locales.map(&:to_s).include?(params[:locale])
      session[:locale] = params[:locale]
    end
    redirect_back fallback_location: root_path
  end
end
