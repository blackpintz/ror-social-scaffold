require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { User.create(name: 'Lucy', email: 'lucy@gmail.com', password: 'password') }

  describe 'User #index' do
    it 'displays all the users' do
      sign_in user
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'User #show' do
    it 'shows the user profile' do
      sign_in user
      get :show, params: { id: user.id }
      expect(response).to render_template(:show)
    end
  end
end
