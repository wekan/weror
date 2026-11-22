# frozen_string_literal: true

class RoomsController < ApplicationController
  def refresh
    # TODO: Implement refresh logic
    render json: { status: "refreshed", since: params[:since], reason: params[:reason] }
  end
end
