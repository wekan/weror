# frozen_string_literal: true

class LanguagesController < ApplicationController
  before_action :set_locale
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    @languages = I18n.available_locales
  end

  def show
    @language = Language.find(params[:id])
  end

  def edit
    @language = Language.find(params[:id])
  end

  def update_locale
    if current_user.update(language: params[:locale])
      I18n.locale = params[:locale]
      redirect_to languages_path, notice: "Locale successfully updated."
    else
      redirect_to languages_path, alert: "Failed to update locale."
    end
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
