class PostsController < ApplicationController
  before_action :require_author, only: [:edit, :update]

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "Post successfully created!"
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "Post successfully edited!"
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to sub_url(@post.sub_id)
  end

  def require_author
    @post = Post.find(params[:id])
    redirect_to sub_url(@post.sub_id) unless current_user.id == @post.user_id
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_id)
  end
end
