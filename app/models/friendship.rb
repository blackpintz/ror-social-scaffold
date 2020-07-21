class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  scope :showRequests, ->(user) { where(friend: user, status: false) }
end
