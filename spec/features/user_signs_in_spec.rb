require 'rails_helper'

feature 'user signs in', %Q{
  As an unauthenticated Urban Explorer
  I want to sign in
  So that I can post trails and review them
} do

  scenario 'An existing user must supply email and password' do
    user = FactoryGirl.create(:user)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(page).to have_content('Welcome back!')
    expect(page).to_not have_content('Sign In')
  end

  scenario 'A existing users email and password do not match' do
    user = FactoryGirl.create(:user)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'shouldnotwork'
    click_button 'Sign In'

    expect(page).to have_content('Invalid Email or password.')
    expect(page).to_not have_content('Welcome back!')
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'A non-existent email and password is supplied' do
    user = FactoryGirl.create(:user)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: 'hi@gmail.com'
    fill_in 'Password', with: 'shouldnotwork'
    click_button 'Sign In'

    expect(page).to have_content('Invalid Email or password.')
    expect(page).to_not have_content('Welcome back!')
    expect(page).to_not have_content('Sign Out')
  end
  scenario 'an already authenticated user cannot re-sign in' do
    user = FactoryGirl.create(:user)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(page).to have_content('Sign Out')
    expect(page).to_not have_content('Sign In')

    visit new_user_session_path

    expect(page).to have_content('You are already signed in.')
  end
end
