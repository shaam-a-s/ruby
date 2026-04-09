class TasksController < ApplicationController
end
class TasksController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @task = @project.tasks.new
  end

  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.new(params.require(:task).permit(:title, :status))

    if @task.save
      redirect_to @project
    else
      render :new
    end
  end

  def index
    @project = Project.find(params[:project_id])
    @tasks = @project.tasks

    if params[:status] == "completed"
      @tasks = @tasks.completed
    elsif params[:status] == "pending"
      @tasks = @tasks.pending
    end
  end
end