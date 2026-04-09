class CommentsController < ApplicationController
  before_action :set_recipe
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def index
    @comments = @recipe.comments.includes(:user)
  end

  def show
  end

  def new
    @comment = @recipe.comments.build
    @users = User.all
  end

  def create
    @comment = @recipe.comments.build(comment_params)

    if @comment.save
      redirect_to recipe_comment_path(@recipe, @comment), notice: "Comment created"
    else
      @users = User.all
      render :new
    end
  end

  def edit
    @users = User.all
  end

  def update
    if @comment.update(comment_params)
      redirect_to recipe_comment_path(@recipe, @comment), notice: "Comment updated"
    else
      @users = User.all
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to recipe_path(@recipe), notice: "Comment deleted"
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def set_comment
    @comment = @recipe.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:title, :user_id)
  end
end