class FriendshipsController < ApplicationController
    def create
        @new_request = Friendship.create(user_id: params[:user_id], friend_id: params[:friend_id])
        redirect_to users_path
    end
end
