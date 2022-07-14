class FriendshipsController < ApplicationController

  def destroy
    @friendship = Friendship.find(params[:id])
    @inverse_friendship = Friendship.find_by(user_id: @friendship.friend_id, friend_id: @friendship.user_id)
    if @friendship.destroy
      if @inverse_friendship.destroy
        flash[:notice] = 'Friend successfully removed.'
        redirect_to people_path
      else
        flash[:alert] = 'Something went wrong.'
        redirect_to people_path
      end
    end
  end

end
