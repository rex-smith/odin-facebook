class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friendship_params)
    @inverse_friendship = User.find(friendship_params[:friend_id]).friendships.build(friend_id: current_user.id)
    if @friendship.save?
      if @inverse_friendship.save?
        flash[:notice] = "Friendship accepted!"
        redirect_to people_path
      else
        flash[:alert] = "Something went wrong."
        redirect_to people_path
      end
    end
  end

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
