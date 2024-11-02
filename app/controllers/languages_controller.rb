# frozen_string_literal: true

class LanguagesController < ApplicationController
  before_action :set_locale
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    @languages = I18n.available_locales
    @current_locale = I18n.locale
  end

  def show
    @language = Language.find(params[:id])
  end

  def edit
    @language = Language.find(params[:id])
  end

  def update_locale
    I18n.locale = params[:locale]
    session[:locale] = I18n.locale
    redirect_back(fallback_location: root_path)
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  # Add other actions (new, create, edit, update, destroy) as needed

  private
    def record_not_found
      redirect_to languages_path, alert: "Language not found."
    end
end
