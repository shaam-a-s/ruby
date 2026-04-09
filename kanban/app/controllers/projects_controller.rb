class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
    @tasks = @project.tasks
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to @project
    else
      render :new
    end
  end

  def destroy
    project = Project.find_by(id: params[:id])

    if project
        project.destroy
        redirect_to projects_path
    else
        redirect_to projects_path, alert: "Project not found"
    end
  end
  private

  def project_params
    params.require(:project).permit(:name, :description)
  end
end