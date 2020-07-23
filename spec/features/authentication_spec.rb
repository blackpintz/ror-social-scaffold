require 'rails_helper'

feature 'authentication features', type: :feature do
  feature 'creating a new user' do
    before(:example) do
      visit '/users/sign_up'
    end

    scenario 'with valid params' do
      fill_in 'user[name]', with: 'Jack'
      fill_in 'user[email]', with: 'jack@gmail.com'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_on 'Sign up'
      expect(page).to have_content('Welcome! You have signed up successfully.')
      expect(current_path).to eq('/')
    end

    scenario 'with invalid params' do
      fill_in 'user[name]', with: 'Jack'
      fill_in 'user[email]', with: 'jack@gmail.com'
      fill_in 'user[password]', with: 'password'
      click_on 'Sign up'
      expect(page).to have_content('Password confirmation doesn\'t match Password')
      expect(current_path).to eq('/users')
    end
  end

  feature 'Log in a user' do
    before(:example) do
      User.create(name: 'Lucy', email: 'lucy@gmail.com', password: 'password')
    end

    scenario 'with valid params' do
      visit 'users/sign_in'
      fill_in 'user[email]', with: 'lucy@gmail.com'
      fill_in 'user[password]', with: 'password'
      click_on 'Log in'
      expect(page).to have_content('Signed in successfully.')
      expect(current_path).to eq('/')
    end

    scenario 'with invalid params' do
      visit 'users/sign_in'
      fill_in 'user[email]', with: 'lucy@gmail.com'
      click_on 'Log in'
      expect(page).to have_content('Invalid Email or password.')
      expect(current_path).to eq('/users/sign_in')
    end
  end

  feature 'Log out user' do
    before(:example) do
      User.create(name: 'Lucy', email: 'lucy@gmail.com', password: 'password')
      visit 'users/sign_in'
      fill_in 'user[email]', with: 'lucy@gmail.com'
      fill_in 'user[password]', with: 'password'
      click_on 'Log in'
    end

    scenario 'Log out user' do
      click_on 'Sign out'
      expect(page).to have_content('You need to sign in or sign up before continuing.')
      expect(current_path).to eq('/users/sign_in')
    end
  end
end
