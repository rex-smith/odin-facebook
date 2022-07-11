class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    if params[:user_id]
      @posts = User.find_by_id(params[:user_id]).posts
    else
      @posts = Post.all.order('created_at DESC')
    end
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        flash[:success] = "Post successfully created."
        format.turbo_stream
      else
        flash[:error] = 'Something went wrong.'
        render :new
      end
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
    params.require(:post).permit(:title, :body, :user_id)
  end

end
