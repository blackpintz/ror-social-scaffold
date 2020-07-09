class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @requests = User.check_friend(params[:user_id])
    render 'users/show'
  end
  
  def friend_request

    # @my_requests = requests.select {|req| req.friend_id == current_user.id}
    # redirect_to user_path(params[:user_id])
  end
end
