class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @found_friends = current_user.friends
  end

  def show
    @users = User.all
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @friend_requests = Friendship.show_requests(params[:id])
  end
end
