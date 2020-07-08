class FriendshipsController < ApplicationController
    def new
       @requests = []
       new_request = Friendship.new(user_id: params[:user_id], friend_id: params[:friend_id])
       @requests << new_request
       byebug
       redirect_to users_path
    end
end
