class RequestsController < ApplicationController
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

  def destroy
    @request = Request.find(params[:id])
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
end
