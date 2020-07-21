require 'rails_helper'

feature 'Friend actions', type: :feature do
  feature 'add friend' do
    before(:example) do
      user1 = User.create(name: 'Rose', email: 'rose@yahoo.com', password: 'password')
      User.create(name: 'Alex', email: 'alex@yahoo.com', password: 'password')
      visit 'users/sign_in'
      fill_in 'user[email]', with: user1.email
      fill_in 'user[password]', with: user1.password
      click_on 'Log in'
      click_on 'All users'
    end

    scenario 'add a new friend' do
      click_on 'Add Alex'
      expect(page).to have_content('Your friend request has been sent.')
      expect(current_path).to eq('/users')
    end
  end

  feature 'accept friend' do
    before(:example) do
      user1 = User.create(name: 'Rose', email: 'rose@yahoo.com', password: 'password')
      user3 = User.create(name: 'Lucy', email: 'lucy@gmail.com', password: 'password')
      visit 'users/sign_in'
      fill_in 'user[email]', with: user1.email
      fill_in 'user[password]', with: user1.password
      click_on 'Log in'
      click_on 'All users'
      click_on 'Add Lucy'
      click_on 'Sign out'
      fill_in 'user[email]', with: user3.email
      fill_in 'user[password]', with: user3.password
      click_on 'Log in'
    end

    scenario 'confirmation for accepting a friend' do
      visit user_url(User.find_by(name: 'Lucy').id)
      expect(page).to have_content('Rose wants to be your friend.')
      expect(current_path).to eq("/users/#{User.find_by(name: 'Lucy').id}")
    end

    scenario 'confirming friend request to yes' do
      visit user_url(User.find_by(name: 'Lucy').id)
      click_on 'Accept'
      expect(page).not_to have_content('Rose wants to be your friend.')
      expect(current_path).to eq("/users/#{User.find_by(name: 'Lucy').id}")
    end

    scenario 'confirming friend request to no' do
      visit user_url(User.find_by(name: 'Lucy').id)
      click_on 'Ignore'
      expect(page).not_to have_content('Rose wants to be your friend.')
      expect(current_path).to eq("/users/#{User.find_by(name: 'Lucy').id}")
    end
  end
end
