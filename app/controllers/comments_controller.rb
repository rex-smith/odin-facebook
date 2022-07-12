class CommentsController < ApplicationController

  def index

  end

  def new
    @comment = current_user.comments.build
  end

  def show

  end

  def edit

  end

  def create
    comment = current_user.comments.build(comment_params)

    respond_to do |format|
      if comment.save
        flash[:notice] = "Comment successfully created."
        redirect_to root_path
      else
        flash[:alert] = "Something went wrong."
        redirect_to root_path
      end
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
