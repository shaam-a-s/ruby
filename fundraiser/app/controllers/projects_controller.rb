class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
    @donations = @project.donations
    @discounts = @project.discounts
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params.require(:project).permit(:name, :description, :goal))

    if @project.save
      redirect_to @project
    else
      render :new
    end
  end
end