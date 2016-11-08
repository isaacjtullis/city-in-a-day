require 'rails_helper'

feature 'User can save trails', %Q{
  As an Urban Explorer
  I want to save my favorite trails
  So I can easily find a list of my favorite places
} do
  before do
    user = FactoryGirl.create(:user)

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    visit root_path

    click_link 'Share Your Own Adventure'
    fill_in 'Name', with: 'Denver Urban Steam'
    fill_in 'Location', with: 'Denver, Colorado'
    fill_in 'Description', with: 'Urban Roast is wild!'
    select('10', :from => 'Price')
    select('Adventure', :from => 'Mood')
    click_button 'Make New Trail'

    click_link 'Sign Out'

    user1 = FactoryGirl.create(:user)

    visit new_user_session_path
    fill_in 'Email', with: user1.email
    fill_in 'Password', with: user1.password
    click_button 'Sign In'
  end
  scenario 'User favorites a trail' do
    visit root_path

    click_button 'Favorite'
    click_link 'John Smith'

    expect(page).to have_content("FAVORITES:")
    expect(page).to have_content("Denver Urban Steam")
  end
  scenario 'User removes a favorite trail' do
    visit root_path

    click_button 'Favorite'
    click_link 'John Smith'

    click_link 'Remove Favorite'

    expect(page).to have_content("Successfully removed this from your favorites")
    expect(page).to_not have_content("FAVORITES:")
  end
  scenario 'User is not logged in' do
    visit root_path
    click_link 'Sign Out'

    visit root_path
    click_button 'Favorite'

    expect(page).to have_content("You must be logged in to make changes!")
  end
end
