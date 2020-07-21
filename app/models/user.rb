class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }
  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :requests_sent, -> { where(status: false) }, class_name: 'Friendship'
  has_many :friend_requests, through: :requests_sent, source: :friend
  has_many :requests_accepted, -> { where(status: true) }, class_name: 'Friendship'
  has_many :accepted_requests, through: :requests_accepted, source: :friend
  has_many :received_accepted_requests, -> { where status: true }, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :received_requests, through: :received_accepted_requests, source: :user
  has_many :received_pending_requests, -> { where status: false }, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :pending_requests, through: :received_pending_requests, source: :user
end
