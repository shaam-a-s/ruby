class DiscountsController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @discount = @project.discounts.new
  end

  def create
    @project = Project.find(params[:project_id])
    @discount = @project.discounts.new(params.require(:discount).permit(:code, :percentage))

    if @discount.save
      redirect_to @project
    else
      render :new
    end
  end
end