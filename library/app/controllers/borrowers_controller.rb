class BorrowersController < ApplicationController
  def index
    @borrowers = Borrower.all
  end

  def show
    @borrower = Borrower.find(params[:id])
  end

  def new
    @borrower = Borrower.new
  end

  def create
    @borrower = Borrower.new(borrower_params)

    if @borrower.save
      redirect_to borrowers_path
    else
      render :new
    end
  end

  def edit
    @borrower = Borrower.find(params[:id])
  end

  def update
    @borrower = Borrower.find(params[:id])
    if @borrower.update(borrower_params)
      redirect_to borrowers_path
    else
      render :edit
    end
  end

  def destroy
    @borrower = Borrower.find(params[:id])
    @borrower.destroy
    redirect_to borrowers_path
  end

  private

  def borrower_params
    params.require(:borrower).permit(:name, :email)
  end
end