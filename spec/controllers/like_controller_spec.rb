require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  let(:user) { User.create(name: 'Lucy', email: 'lucy@gmail.com', password: 'password') }

  describe 'Like #create' do
    it 'adds a like on a post' do
      sign_in user
      post1 = user.posts.create(content: 'A new post.')
      post :create, params: { post_id: post1.id }
      expect(response).to redirect_to(posts_path)
      expect(flash[:notice]).to match(/You liked a post/)
    end
  end

  describe 'Like #destroy' do
    it 'deletes a like on a post' do
      sign_in user
      post1 = user.posts.create(content: 'A new post.')
      like1 = user.likes.create(post_id: post1.id)
      delete :destroy, params: { id: like1.id, post_id: post1.id }
      expect(response).to redirect_to(posts_path)
      expect(flash[:notice]).to match(/You disliked a post/)
    end
  end
end
