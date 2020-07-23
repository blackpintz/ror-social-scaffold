require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user1) { User.create(name: 'Rose', email: 'rose@yahoo.com', password: 'password') }
  let(:user2) { User.create(name: 'Alex', email: 'alex@yahoo.com', password: 'password') }
  let(:user3) { User.create(name: 'Dan', email: 'dan@yahoo.com', password: 'password') }
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:friend).class_name('User') }
  end

  describe 'class methods' do
    describe '::show_requests(id)' do
      it 'returns sent friend requests' do
        friend1 = Friendship.create(user_id: user1.id, friend_id: user2.id)
        expect(Friendship.showRequests(user2.id)).to include(friend1)
      end
    end
  end

  describe 'validations' do
    describe '.check_status' do
      before(:example) do
        Friendship.create(user_id: user3.id, friend_id: user2.id)
      end
      it 'checks where a friendship or friend request exists' do
        friend3 = Friendship.new(user_id: user3.id, friend_id: user2.id)
        friend3.valid?
        friend3.errors.full_messages.should include('Friendship status Your friendship request is pending!')
      end
    end
  end
end
