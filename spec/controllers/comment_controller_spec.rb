require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { User.create(name: 'Lucy', email: 'lucy@gmail.com', password: 'password') }

  describe 'Comment #create' do
    context 'it redirects to posts#index when successful' do
      it 'redirects to the posts index page' do
        post1 = user.posts.create(content: 'A new post.')
        post :create, params: { comment: { content: 'Thanks' }, post_id: post1.id, user_id: user.id }
        expect(response).to redirect_to(posts_path)
      end
    end

    context 'it redirects to posts page with alert message, when unsuccessful' do
      it 'redirects to post index page with an alert' do
        post1 = user.posts.create(content: 'A new post.')
        post :create, params: { comment: { content: '' }, post_id: post1.id, user_id: user.id }
        expect(response).to redirect_to(posts_path)
        expect(flash[:alert]).to match(/Content can't be blank/)
      end
    end
  end
end
