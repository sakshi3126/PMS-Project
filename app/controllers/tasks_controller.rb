class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_project, except: [:show, :edit]
  before_action :authenticate_user!, only: [:edit, :update, :destroy]


  # GET /tasks
  # GET /tasks.json
  def index
    if user_signed_in?
      @tasks = current_user.tasks
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @project = @task.project
  end

  # GET /tasks/new
  def new
    # @task = Task.new(project: @project)
    @task = @project.tasks.build()
  end

  # GET /tasks/1/edit
  def edit
    # @project = @task.project
  end

  # POST /tasks
  # POST /tasks.json
  def create
    # @task = @project.tasks.new()
    @task = Task.new(task_params)
    respond_to do |format|
      if @task.save
        format.html { redirect_to project_path(@task.project_id), notice: 'Task was successfully created.' }
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
    task_status = "task_status_#{@task.id}"
    if Rails.cache.exist?(task_status)
      Rails.cache.delete(task_status)
    end
    Rails.cache.write(task_status, @task)
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to project_path(@task.project_id), notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end





  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to project_path(@task.project_id), notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  def set_project
    if params[:id]
      @project = Project.find_by(id: params[:id])
    else
      @project = Project.find_by(id: params[:project_id])
    end
  end

  # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit(:name, :description, :task_status, :priority, :task_date, :date, :project_id, :user_id)
  end
end
