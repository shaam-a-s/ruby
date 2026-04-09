class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :set_users, only: [:new, :edit, :show]

  def index
    @recipes = Recipe.all.includes(:user)
  end

  def show
    @comment = Comment.new
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to @recipe, notice: "Recipe created"
    else
      set_users
      render :new
    end
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: "Recipe updated"
    else
      set_users
      render :edit
    end
  end

  def destroy
    @recipe.destroy
    redirect_to recipes_path, notice: "Recipe deleted"
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def set_users
    @users = User.all
  end

  def recipe_params
    params.require(:recipe).permit(:title, :ingredients, :user_id)
  end
end