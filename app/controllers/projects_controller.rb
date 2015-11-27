class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :verify_command, only: :show

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.where(is_active: true)
  end

  def archive
    @projects = Project.where(is_active: false)
  end

  def tasks_archive
    @project = Project.find(params[:project_id])
    @tasks = @project.tasks.where(is_active: false)
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to projects_path, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to projects_url, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Verify if the user wants to deactivate or activate a project
    def verify_command
      if params[:command].present?
        if params[:command] == 'deactivate'
          deactivate
        elsif params[:command] == 'activate'
          activate
        end
      end
    end

    def activate
      Project.find(params[:id]).activate

      respond_to do |format|
        format.html { redirect_to projects_path, notice: 'O projeto foi desarquivado com sucesso.' }
        format.json { head :no_content }
      end
    end

    def deactivate
      Project.find(params[:id]).deactivate

      respond_to do |format|
        format.html { redirect_to :back, notice: 'O projeto foi arquivado com sucesso.' }
        format.json { head :no_content }
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :description, :start_date, :end_date, :image, :customer, :developers => [])
    end
end
