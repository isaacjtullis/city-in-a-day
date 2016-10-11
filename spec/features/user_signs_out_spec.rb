require 'rails_helper'

feature 'user signs out', %Q{
  As a Urban Explore
  I want to sign out
  So others cannot post in my name
} do
  scenario 'User can sign out' do
    user = FactoryGirl.create(:user)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    click_link 'Sign Out'
    expect(page).to have_content('You have signed out successfully!')
    expect(page).to have_content('Sign In')
    expect(page).to_not have_content('Sign out')
  end
  scenario 'User can sign out, sign in, sign out' do
    user = FactoryGirl.create(:user)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    click_link 'Sign Out'

    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    click_link 'Sign Out'
    expect(page).to have_content('You have signed out successfully!')
    expect(page).to have_content('Sign In')
    expect(page).to_not have_content('Sign out')
  end
end
