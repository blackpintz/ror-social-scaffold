require 'rails_helper'

RSpec.describe FriendshipsController, type: :controller do
  let(:user1) { User.create(name: 'Lucy', email: 'lucy@gmail.com', password: 'password') }
  let(:user2) { User.create(name: 'Ali', email: 'ali@gmail.com', password: 'password') }
  let(:user3) { User.create(name: 'julie', email: 'julie@gmail.com', password: 'password') }
  describe 'Friendship #create' do
    it 'enables a user to add another user as a friend' do
      post :create, params: { user_id: user1.id, friend_id: user2.id }
      expect(response).to redirect_to(users_path)
    end
  end

  describe 'Friendship #update' do
    it 'updates the status of friendship to true' do
      user2.friends << user3
      patch :update, params: { id: user3.id, user_id: user2.id, friend_id: user3.id }
      expect(response).to redirect_to(user_path(user3))
    end
  end

  describe 'Friendship #delete' do
    it 'deletes a friend request' do
      user2.friends << user3
      delete :destroy, params: { id: user3.id, user_id: user2.id, friend_id: user3.id }
      expect(response).to redirect_to(user_path(user3))
    end
  end
end
