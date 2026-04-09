class TagsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @tag = @post.tags.new
  end

  def create
    @post = Post.find(params[:post_id])
    @tag = @post.tags.new(params.require(:tag).permit(:name))

    if @tag.save
      redirect_to @post
    else
      render :new
    end
  end
end