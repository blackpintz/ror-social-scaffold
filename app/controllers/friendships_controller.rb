class FriendshipsController < ApplicationController
  def create
    Friendship.create(user_id: params[:user_id], friend_id: params[:friend_id])
    redirect_to users_path
  end

  def update
    @user = User.find(params[:id])
    @friend = Friendship.find_by(user_id: params[:user_id], friend_id: params[:friend_id])
    @friend.update(status: true)
    redirect_to user_path
  end

  def destroy
    @friend = Friendship.find_by(user_id: params[:user_id], friend_id: params[:friend_id])
    @friend.destroy
    redirect_to user_path
  end
end
