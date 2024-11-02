# frozen_string_literal: true

# Workspaces Controller
class WorkspacesController < ApplicationController
  before_action :set_workspace, only: %i[show edit update destroy]
  before_action :authenticate_user!

  # GET /workspaces or /workspaces.json
  def index
    @workspaces = Current.user.memberships.includes(:workspace).map(&:workspace)
    @my_workspaces = Current.user.workspaces.mine
    @others_workspaces = Current.user.workspaces.others
  end

  # GET /workspaces/1 or /workspaces/1.json
  def show; end

  # GET /workspaces/new
  def new
    @workspace = Current.user.workspaces.new
    authorize @workspace
  end

  # GET /workspaces/1/edit
  def edit; end

  # POST /workspaces or /workspaces.json
  def create
    @workspace = Current.user.workspaces.new(workspace_params)
    authorize @workspace

    respond_to do |format|
      if @workspace.save
        Current.user.workspaces << @workspace
        format.html { redirect_to workspace_url(@workspace), notice: "Workspace was successfully created." }
        format.json { render :show, status: :created, location: @workspace }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @workspace.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workspaces/1 or /workspaces/1.json
  def update
    respond_to do |format|
      if @workspace.update(workspace_params)
        format.html { redirect_to workspace_url(@workspace), notice: "Workspace was successfully updated." }
        format.json { render :show, status: :ok, location: @workspace }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @workspace.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workspaces/1 or /workspaces/1.json
  def destroy
    @workspace.destroy!

    respond_to do |format|
      format.html { redirect_to workspaces_url, notice: "Workspace was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workspace
      @workspace = Current.user.workspaces.find(params[:id])
      authorize @workspace
    end

    # Only allow a list of trusted parameters through.
    def workspace_params
      params.require(:workspace).permit(:name)
    end

    def authenticate_user!
      redirect_to login_path unless Current.user
    end
end
