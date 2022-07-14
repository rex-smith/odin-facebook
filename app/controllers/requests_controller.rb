class RequestsController < ApplicationController
  before_action :set_friend_request, except: :create

  def create
    @request = current_user.requests.build(request_params)
    if @request.save
      flash[:notice] = "Friend request sent"
      redirect_to people_path
      # May need to redirect to creating an invitation here
    else
      flash[:alert] = "Something went wrong"
      redirect_to people_path
    end
  end

  def confirm
    # Create friendship
    @friendship = current_user.friendships.build(friendship_params)
    @inverse_friendship = User.find(friendship_params[:friend_id]).friendships.build(friend_id: current_user.id)
    if @friendship.save
      if @inverse_friendship.save
        # Destroy request in the process
        @request.destroy
        flash[:notice] = "Friendship accepted!"
        redirect_to people_path
      else
        flash[:alert] = "Something went wrong."
        redirect_to people_path
      end
    end
  end

  def delete
    if @request.destroy
      flash[:notice] = 'Request successfully deleted.'
      redirect_to people_path
    else
      flash[:alert] = 'Something went wrong.'
      redirect_to people_path
    end
  end

  private

  def request_params
    params.require(:request).permit(:requested_friend_id)
  end

  def set_friend_request
    @request = Request.find(params[:id])
  end

  def friendship_params
    params.require(:friendship).permit(:friend_id)
  end
end
