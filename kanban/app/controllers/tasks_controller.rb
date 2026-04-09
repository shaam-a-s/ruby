class TasksController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.build(task_params)

    if @task.save
      redirect_to @project
    else
      render 'projects/show'
    end
  end

  def update
    @task = Task.find(params[:id])
    @task.update(status: params[:task][:status])
    head :ok
  end

  def destroy
    task = Task.find(params[:id])
    project = task.project
    task.destroy
    redirect_to project
  end

  private

  def task_params
    params.require(:task).permit(:name, :status, :priority)
  end
end