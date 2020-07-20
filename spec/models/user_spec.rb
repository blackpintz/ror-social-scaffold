require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it 'should validate the length of name' do
      should validate_length_of(:name).is_at_most(20)
    end
  end

  describe 'associations' do
    it { should have_many(:posts) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
    it { should have_many(:friendships) }
    it { should have_many(:friends).through(:friendships) }
    it { should have_many(:requests_sent).conditions(status: false).class_name('Friendship') }
    it { should have_many(:friend_requests).through(:requests_sent).source(:friend) }
    it { should have_many(:requests_accepted).conditions(status: true).class_name('Friendship') }
    it { should have_many(:accepted_requests).through(:requests_accepted).source(:friend) }
    it do
      should have_many(:received_accepted_requests)
        .conditions(status: true)
        .class_name('Friendship')
        .with_foreign_key('friend_id')
    end
    it { should have_many(:received_requests).through(:received_accepted_requests).source(:user) }
    it do
      should have_many(:received_pending_requests)
        .conditions(status: false)
        .class_name('Friendship')
        .with_foreign_key('friend_id')
    end
    it { should have_many(:pending_requests).through(:received_pending_requests).source(:user) }
  end
end
