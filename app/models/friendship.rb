class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  
  def self.friend_requests(userid, friendid)
    create(user_id: userid, friend_id: friendid)
  end
  
  def self.show_requests(id)
    where(status: false, friend_id: id)
  end
end
