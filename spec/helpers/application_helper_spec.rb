require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  let(:user1) { User.create(name: 'Rose', email: 'rose@yahoo.com', password: 'password') }
  let(:user2) { User.create(name: 'Alex', email: 'alex@yahoo.com', password: 'password') }
  let(:post1) { Post.create(content: 'New post', user_id: user1.id) }
  describe '#like_or_dislike_btn' do
    it 'likes a post' do
      expect(helper.like_or_dislike_btn(post1)).to include('Like!')
    end
  end

  describe '#accept_button' do
    it 'returns all requests for the current user' do
      Friendship.create(user_id: user1.id, friend_id: user2.id, status: false)
      allow(helper).to receive(:current_user).and_return(user2)
      expect(helper.accept_button(user1)).not_to be_nil
    end
  end

  describe '#ignore_button' do
    it 'returns all requests for the current user' do
      Friendship.create(user_id: user1.id, friend_id: user2.id, status: false)
      allow(helper).to receive(:current_user).and_return(user2)
      expect(helper.ignore_button(user1)).not_to be_nil
    end
  end

  describe '#pending_requests' do
    it 'returns friend requests sent by current_user' do
      Friendship.create(user_id: user2.id, friend_id: user1.id)
      allow(helper).to receive(:current_user).and_return(user2)
      expect(helper.pending_requests(user1)).to eq true
    end
  end

  describe 'request_status' do
    it 'returns true if the current user has sent a friend request to user2 and vice versa' do
      Friendship.create(user_id: user1.id, friend_id: user2.id)
      expect(helper.request_status(user1, user2)).to eq true
    end
  end

  describe '#user_accepted_requests' do
    it 'returns friends who have accepted current_user request' do
      Friendship.create(user_id: user1.id, friend_id: user2.id, status: true)
      allow(helper).to receive(:current_user).and_return(user1)
      expect(helper.user_accepted_requests(user2)).to eq true
    end
  end

  describe 'we_friends' do
    it 'returns true if the current user has sent a friend request to user2 and vice versa' do
      Friendship.create(user_id: user1.id, friend_id: user2.id, status: true)
      expect(helper.we_friends?(user1, user2)).to eq true
    end
  end
end
