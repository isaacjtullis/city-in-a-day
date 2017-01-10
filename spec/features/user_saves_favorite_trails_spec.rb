require 'rails_helper'

feature 'User can save trails', %Q{
  As an Urban Explorer
  I want to save my favorite trails
  So I can easily find a list of my favorite places
} do
  before do
    user = FactoryGirl.create(:user)

    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Sign In'

    visit root_path

    click_link 'Share Your Own Adventure'
    fill_in 'trail_name', with: 'Denver Urban Steam'
    select('Adventure', :from => 'trail_mood')
    click_button 'Submit'

    fill_in 'location_name', with: 'Denver, Colorado'
    fill_in 'location_location', with: 'Urban Roast is wild!'
    fill_in 'location_description', with: 'Bring cash!'
    select('10', :from => 'location_price')
    click_button 'Make New Location'

    click_link 'Sign Out'

    user1 = FactoryGirl.create(:user)

    visit new_user_session_path
    fill_in 'user_email', with: user1.email
    fill_in 'user_password', with: user1.password
    click_button 'Sign In'
  end
  scenario 'User favorites a trail' do
    visit root_path

    click_button 'Favorite'
    click_link 'John Smith'

    expect(page).to have_content("FAVORITES:")
    expect(page).to have_content("Denver Urban Steam")
  end
  scenario 'Favorites does not show up unless they click the favorite button' do
    visit root_path
    click_link 'John Smith'

    expect(page).to_not have_content("Denver Urban Steam")
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
  scenario 'User signs up and does not have a previous favorited trail on their profile' do
    visit root_path
    click_button 'Favorite'
    click_link 'Sign Out'

    user2 = FactoryGirl.create(:user)

    visit new_user_session_path
    fill_in 'user_email', with: user2.email
    fill_in 'user_password', with: user2.password
    click_button 'Sign In'
    click_link 'John Smith'

    expect(page).to_not have_content('Denver Urban Steam')
  end
end
