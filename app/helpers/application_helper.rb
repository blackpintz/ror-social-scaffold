module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to('Dislike!', post_like_path(id: like.id, post_id: post.id), method: :delete)
    else
      link_to('Like!', post_likes_path(post_id: post.id), method: :post)
    end
  end
  
  def sent_request(current)
    requests = Friendship.where(user_id: current.id, status: false)
    !!requests
  end
  
  def received_request(user)
    requests = Friendship.where(friend_id: user.id, status: false)
    !!requests
  end
  
  def request_status(current,user)
    (sent_request(current) && received_request(user)) || (sent_request(user) && received_request(current))
  end
  
  def accepted_requests(id)
    friend = Friendship.where(friend_id: id, status: true)
    !!friend.first
  end
  
  def my_friends(id)
    friend = Friendship.where(user_id: id, status: true)
    !!friend.first
  end
  
  def check_friend_status(current, user)
    (accepted_requests(current.id) && my_friends(user.id)) || (accepted_requests(user.id) && my_friends(current.id))
  end
end
