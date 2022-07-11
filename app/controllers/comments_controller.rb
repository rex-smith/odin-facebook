class CommentsController < ApplicationController

  def index

  end

  def new
    # @post = Post.find(params[:post_id])
    @comment = current_user.comments.build
  end

  def show

  end

  def edit

  end

  def create
    comment = current_user.comments.build(comment_params)
    if comment.save
      flash[:success] = "Comment successfully created."
      redirect_to root_path
    else
      flash[:error] = "Something went wrong."
      redirect_to root_path
    end
  end

  def update

  end

  def destroy 

  end

  private
  
  def comment_params
    params.require(:comment).permit(:body, :user_id, :commentable_id, :commentable_type)
  end



end