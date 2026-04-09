class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @tags = @post.tags
  end

  def new
    @post = Post.new
    @users = User.all
  end

  def create
    @post = Post.new(params.require(:post).permit(:title, :content, :user_id))

    if @post.save
      redirect_to @post
    else
      render :new
    end
  end
end