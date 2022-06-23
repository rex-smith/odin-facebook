class PostsController < ApplicationController

  def index
    if params[:user_id]
      @posts = User.find_by_id(params[:user_id]).posts
    else
      @posts = Post.all.order('created_at DESC')
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      flash[:success] = "Post successfully created."
      redirect_to root_path
    else
      flash[:error] = 'Something went wrong.'
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:success] = 'Post successfully removed.'
      redirect_to posts_url
    else
      flash[:error] = 'Something went wrong.'
      redirect_to posts_url
    end
  end

  private

  def post_params
    params.require(:posts).permit(:title, :body, :user_id)
  end

end
