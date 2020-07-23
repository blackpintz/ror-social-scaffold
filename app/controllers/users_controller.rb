class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show]

  def index
    @users = User.all
  end

  def show
    @users = User.all
    @posts = @user.posts.ordered_by_most_recent
    show_requests
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def show_requests
    @show_requests ||= Friendship.showRequests(@user)
  end
end
