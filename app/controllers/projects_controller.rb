class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy, :update_task]


  def index
    if user_signed_in?
      @projects = current_user.projects
    else
      flash[:alert] = "Create Your Project"
    end
  end

  def new
    @project = Project.new
    @project.tasks.build
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to project_path(@project)
    else
      @project
      render :new
    end
  end

  def show
    # @project = Project.find_by(id: params[:id])
  end

  def edit

  end

  def update
    if @project.update(project_params)
      redirect_to project_path(@project)
    else
      render :show
    end
  end
  def update_task
    @project.update(project_params)
    redirect_to project_path(@project)
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_path, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  ## ADDITIONAL ACTIONS


  ## PRIVATE METHODS

  private

  def set_project
    if params[:id]
      @project = Project.find_by(id: params[:id])
    else
      @project = Project.find_by(id: params[:project_id])
    end
  end

  # def project_statuses_count
  #   @overdue = (current_user.overdue_projects + current_user.collaboration_projects.overdue).uniq.count
  #   @active = (current_user.active_projects + current_user.collaboration_projects.active).uniq.count
  #   @complete = (current_user.complete_projects + current_user.collaboration_projects.complete).uniq.count
  # end

  def project_params
    params.require(:project).permit(:name, :description, :user_id, :due_date, :status,
                                    tasks_attributes: [:name, :description, :task_status, :priority, :task_date, :project_id, :user_id, :_destroy])
  end
end
