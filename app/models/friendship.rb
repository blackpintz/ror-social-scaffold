class Friendship < ApplicationRecord
  validate :check_status, on: :create
  after_update :make_friendship_official
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  scope :showRequests, ->(user) { where(friend: user, status: false) }

  private

  def check_status
    errors.add(:friendship_status, 'You are already friends!') if Friendship.find_by(user_id: user_id, friend_id: friend_id, status: true).present?
    errors.add(:friendship_status, 'Your friendship request is pending!') if Friendship.find_by(user_id: user_id, friend_id: friend_id, status: false).present?
  end

  def make_friendship_official
    Friendship.create(user_id: friend_id, friend_id: user_id, status: true)
  end
end
