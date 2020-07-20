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

  
  def accept_button(user)
    requests_sent = user.friend_requests
      return link_to( 'Accept', friendship_path(user, user_id: user.id, friend_id: current_user.id), method: :put, class: 'frnd-btn') if requests_sent.include?(current_user)
      nil
  end
  
  def confirmation_msg(user)
    return user.name + " wants to be your friend" if accept_button(user)
  end
  
  def display_friends(user1, user2)
     if we_friends?(user1, user2)
      user2.name 
     end
  end
  def ignore_button(user)
    requests_sent = user.friend_requests
    return link_to( 'Ignore', friendship_path(user, user_id: user.id, friend_id: current_user.id), method: :delete, class: 'ignore-btn') if requests_sent.include?(current_user)
    nil
  end

  def pending_requests(user)
    requests = current_user.friend_requests
    requests.include?(user)
  end

  def request_status(user1, user2)
    user1_requests = user1.friend_requests
    user2_requests = user2.friend_requests
    user1_requests.include?(user2) || user2_requests.include?(user1)
  end

  def user_accepted_requests(user)
    friends = current_user.accepted_requests
    friends.include?(user)
  end

  def we_friends?(user1,user2)
    user1_friends = user1.accepted_requests
    user2_friends = user2.accepted_requests
    user1_friends.include?(user2) ||  user2_friends.include?(user1)
  end
  
  def add_friend_btn(user)
      return link_to('Add ' + user.name, friendships_path(user_id: current_user.id, friend_id: user.id),
      method: :post, data: {disable_with: 'Pending'}, class: 'frnd-btn') unless (we_friends?(current_user,user) || user == current_user || request_status(current_user, user))
      nil
  end

    def friend_msg(user1, user2)
      return "You are friends." if we_friends?(user1, user2)
    end

  def request_alert_msg(user)
   return "Your friend request has been sent." if (!user_accepted_requests(user) && pending_requests(user))
  end
  
  def requests_visibility(user)
    render partial: "friendRequests", collection: @show_requests, as: :friend if user == current_user
  end
  
  def posts_visibility(user)
    render @posts if user == current_user || we_friends?(current_user,user)
  end
end
