class SystemsController < ApplicationController
  before_action :set_system, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:some_action_without_auth]

  # GET /systems
  # GET /systems.json
  def index
    @systems = System.all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_system
      @system = System.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def system_params
      params[:system]
    end
end
