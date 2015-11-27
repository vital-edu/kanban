class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :verify_command, only: :show

  # GET /tasks/new
  def new
    @task = Task.new
    @task.project_id = params[:project_id]
    @task.stage_id = params[:stage_id]
  end

  def archive
    @tasks = Tasks.where(is_active: false)
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task.project, notice: 'Tarefa criada com sucesso.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task.project, notice: 'Tarefa atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Verify if the user wants to deactivate or activate a task
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
      Task.find(params[:id]).activate

      respond_to do |format|
        format.html { redirect_to :back, notice: 'A tarefa foi desarquivada com sucesso.' }
        format.json { head :no_content }
      end
    end

    def deactivate
      Task.find(params[:id]).deactivate

      respond_to do |format|
        format.html { redirect_to :back, notice: 'A tarefa foi arquivada com sucesso.' }
        format.json { head :no_content }
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, :priority, :description, :progress, :project_id, :stage_id)
    end
end
