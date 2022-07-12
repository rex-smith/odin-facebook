class LikesController < ApplicationController
  def create
    @like = current_user.likes.build(like_params)

    if @like.save
      flash[:notice] = "Like successfully created."
      redirect_to root_path
    else
      flash[:alert] = 'Something went wrong.'
      render :new
    end
  end

  def destroy
    @like = Like.find(params[:id])
    if @like.destroy
      flash[:notice] = 'Like successfully removed.'
      redirect_to root_path
    else
      flash[:alert] = 'Something went wrong.'
      redirect_to root_path
    end
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :likeable_id, :likeable_type)
  end


end
