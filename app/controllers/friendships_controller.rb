class FriendshipsController < ApplicationController
    def new
        @new_request = Friendship.friend_requests(params[:user_id], params[:friend_id])
        redirect_to users_path
    end
end
