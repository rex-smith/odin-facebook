class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all.order('created_at ASC')
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "Event was successfully updated." }
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
      flash[:success] = 'User successfully removed.'
      redirect_to users_url
    else
      flash[:error] = 'Something went wrong.'
      redirect_to users_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :name, :birthdate, :gender, :address, :phonenumber)
  end

end
