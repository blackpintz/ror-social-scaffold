require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user1) { User.create(name: 'Rose', email: 'rose@yahoo.com', password: 'password') }
  let(:user2) { User.create(name: 'Alex', email: 'alex@yahoo.com', password: 'password') }
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:friend).class_name('User') }
  end

  describe 'class methods' do
    describe '::show_requests(id)' do
      it 'returns sent friend requests' do
        friend1 = Friendship.create(user_id: user1.id, friend_id: user2.id)
        expect(Friendship.show_requests(user2.id)).to include(friend1)
      end
    end
  end
end
