class FriendshipsController < ApplicationController
  
  def destroy
    @friendship = Friendship.find(params[:id])
    if @friendship.destroy
      flash[:notice] = 'Friend successfully removed.'
      redirect_to people_path
    else
      flash[:alert] = 'Something went wrong.'
      redirect_to people_path
    end
  end

  private

  def friendship_params
    params.require(:friendship).permit(:friend_id)
  end

end
