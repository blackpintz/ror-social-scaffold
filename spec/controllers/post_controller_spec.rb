require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { User.create(name: 'Lucy', email: 'lucy@gmail.com', password: 'password') }
  describe 'POST #index' do
    it 'shows all the created posts' do
      sign_in user
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'POST #create' do
    context 'Valid params' do
      it 'creates a new post' do
        sign_in user
        post :create, params: { post: { content: 'A new post.' } }
        expect(response).to redirect_to(posts_path)
      end
    end

    context 'Invalid params' do
      it 'returns an error for invalid post' do
        sign_in user
        post :create, params: { post: { content: '' } }
        expect(response).to render_template(:index)
      end
    end
  end
end
