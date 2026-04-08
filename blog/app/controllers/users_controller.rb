class UsersController < ApplicationController
  def index
    @users=User.all
  end

  def show
    @user=User.find(params[:id])
    @posts=@user.posts
  end
  def new
    @user=User.new
  end

  def create
    @user=User.new(params.require(:user).permit(:name,:email))

    if @user.save
      redirect_to @user
    else
      render :new
    end
  end
end
