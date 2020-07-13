require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  let(:user1) { User.create(name: 'Rose', email: 'rose@yahoo.com', password: 'password') }
  let(:user2) { User.create(name: 'Alex', email: 'alex@yahoo.com', password: 'password') }
  let(:post1) {Post.create(content: "New post", user_id: user1.id)}
  describe "#like_or_dislike_btn" do
    it "likes a post" do
          expect(helper.like_or_dislike_btn(post1)).to include("Like!")
    end

  end
  
  describe "#pending_requests" do
      it "returns pending requests" do
          Friendship.create(user_id: user1.id, friend_id: user2.id)
          expect(helper.pending_requests(user1, user2)).to eq true
      end
  end
  
  describe "#accepted_requests" do
      it "returns accepted requests" do
         Friendship.create(user_id: user1.id, friend_id: user2.id, status: true)
         expect(helper.accepted_requests(user1, user2)).to eq true
      end
  end
  
  describe "#my_friend?" do
      it "returns the users friends" do
          Friendship.create(user_id: user1.id, friend_id: user2.id, status: true)
          expect(helper.my_friend?(user1, user2)).to eq true
      end
  end
end
