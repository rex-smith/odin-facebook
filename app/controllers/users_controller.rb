class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all.order('created_at ASC')
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order('created_at DESC')
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "Profile was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = 'User successfully removed.'
      redirect_to users_url
    else
      flash[:alert] = 'Something went wrong.'
      redirect_to users_url
    end
  end

  def people
    @user = current_user
    @old_requests = current_user.old_requests
    @new_requests = current_user.new_requests
    current_user.update(notification_view: DateTime.now)
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, :birthdate, :gender, :address, :phone_number, :avatar)
  end

end
