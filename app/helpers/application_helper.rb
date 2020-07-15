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

  def show_requests_on_userlist(user, friend)
    friend = Friendship.where(user_id: user, friend_id: friend, status: false)
    !!friend.first
  end

  def pending_requests(current, user)
    requests = Friendship.where(user_id: current.id, friend_id: user.id)
    !!requests.first
  end

  def accepted_requests(current, user)
    friend = Friendship.where(user_id: current.id, friend_id: user.id, status: true)
    !!friend.first
  end

  def request_alert(current, user)
    !accepted_requests(current, user) && pending_requests(current, user)
  end

  def my_friend?(user, friend)
    friend = Friendship.where(user_id: user, friend_id: friend, status: true)
    !!friend.first
  end
end
