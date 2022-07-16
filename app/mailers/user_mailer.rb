class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def welcome_email
    @user = params[:user]
    @url  = root_url
    mail(to: @user.email, subject: 'Welcome to Odinbook')
  end

  def request_email
    @request = params[:request]
    @requester = User.find(@request.user_id)
    @requested_friend = User.find(@request.requested_friend_id)
    @url = root_url
    mail(to: @requested_friend.email, subject: "#{@requester.full_name} sent you a friend request!")
  end
end
