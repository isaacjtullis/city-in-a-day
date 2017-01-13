require 'rails_helper'

feature 'User creates a location for a trail', %Q{
  As an urban explorer,
  I want to add locations to a trail,
  So that I can personalize a trail.
} do
  scenario 'Unregistered user cannot make a form' do
    visit root_path

    click_link 'Share Your Own Adventure'
    fill_in 'trail_name', with: 'Denver Urban Steam'
    select('Adventure', :from => 'trail_mood')
    click_button 'Submit'

    expect(page).to have_content('You must be signed in')
    expect(page).to have_content('Sign In')
  end
  scenario 'User can edit the trail they made' do
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
    fill_in 'location_price', with: '10'
    click_button 'Make New Location'
    click_link 'Edit Location'

    fill_in 'location_name', with: 'Kansas City, KS'
    fill_in 'location_location', with: 'KC area'
    fill_in 'location_description', with: 'Bring cash!'
    fill_in 'location_price', with: '10'
    click_button 'Make New Location'

    expect(page).to have_content('Kansas City, KS')
    expect(page).to have_content('KC area')
  end
  scenario 'User edits a trail and makes it incomplete' do
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
    fill_in 'location_price', with: '10'
    click_button 'Make New Location'
    click_link 'Edit Location'

    fill_in 'location_name', with: 'Kansas City, KS'
    fill_in 'location_location', with: ''
    fill_in 'location_description', with: 'Bring cash!'
    fill_in 'location_price', with: '10'
    click_button 'Make New Location'

    expect(page).to have_content('Opps. We got some problems with that')
  end
end
