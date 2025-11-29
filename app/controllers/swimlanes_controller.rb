class SwimlanesController < ApplicationController
  before_action :set_board
  before_action :set_swimlane, only: [:edit, :update, :destroy]

  def new
    @swimlane = @board.swimlanes.new
  end

  def create
    @swimlane = @board.swimlanes.new(swimlane_params)
    if @swimlane.save
      redirect_to board_path(@board), notice: 'Swimlane created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @swimlane.update(swimlane_params)
      redirect_to board_path(@board), notice: 'Swimlane updated.'
    else
      render :edit
    end
  end

  def destroy
    @swimlane.destroy
    redirect_to board_path(@board), notice: 'Swimlane deleted.'
  end

  private
  def set_board
    @board = if params[:board_id]
      Board.find(params[:board_id])
    elsif params[:id]
      Swimlane.find(params[:id]).board
    end
  end

  def set_swimlane
    @swimlane = @board.swimlanes.find(params[:id])
  end

  def swimlane_params
    params.require(:swimlane).permit(:title)
  end
end
