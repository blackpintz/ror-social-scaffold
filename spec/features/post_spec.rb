require 'rails_helper'

feature 'Post actions', type: :feature do
  feature 'view, add, like and comment on posts' do
    before(:example) do
      user = User.create(name: 'Lucy', email: 'lucy@gmail.com', password: 'password')
      Post.create(content: 'New post', user_id: user.id)
      visit 'users/sign_in'
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_on 'Log in'
    end

    scenario 'viewing posts' do
      click_on 'Stay in touch'
      expect(page).to have_content('New post')
      expect(current_path).to eq('/')
    end

    scenario 'adding new posts' do
      click_on 'Stay in touch'
      fill_in 'post[content]', with: 'A second post'
      click_on 'Save'
      expect(page).to have_content('Post was successfully created.')
      expect(current_path).to eq('/posts')
    end

    scenario 'liking new posts' do
      click_on 'Stay in touch'
      click_on 'Like!'
      expect(page).to have_content('You liked a post.')
      expect(current_path).to eq('/posts')
    end

    scenario 'adding a comment' do
      click_on 'Stay in touch'
      fill_in 'comment[content]', with: 'Nice to meet you.'
      click_on 'Comment'
      expect(page).to have_content('Comment was successfully created.')
      expect(current_path).to eq('/posts')
    end
  end
end
