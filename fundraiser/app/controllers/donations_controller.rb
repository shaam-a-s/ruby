class DonationsController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @donation = @project.donations.new
  end

  def create
    @project = Project.find(params[:project_id])
    @donation = @project.donations.new(params.require(:donation).permit(:amount))

    if @donation.save
      redirect_to @project
    else
      render :new
    end
  end
end