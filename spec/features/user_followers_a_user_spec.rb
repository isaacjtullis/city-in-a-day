require 'rails_helper'

feature 'User follows a user', %Q{
  As an urban explorer,
  I want to follow another user,
  So that I can see what others share.
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
    fill_in 'location_price', with: '10'
    click_button 'Make New Location'

    click_link 'Sign Out'

    visit root_path
    click_link 'Sign Up'
    fill_in 'user_first_name', with: 'Isaac'
    fill_in 'user_last_name', with: 'Tullis'
    fill_in 'user_email', with: 'user1@example.com'
    fill_in 'user_password', with: 'password1'
    fill_in 'user_password_confirmation', with: 'password1'
    click_button 'Sign Up'

  end
  scenario 'User follows a user' do
    visit root_path
    click_link 'Denver Urban Steam'
    click_link 'John Smith'
    click_button 'Follow'

    expect(page).to have_content("Unfollow")
    expect(page).to have_content(1)
  end
  scenario 'User unfollows a user' do
    visit root_path
    click_link 'Denver Urban Steam'
    click_link 'John Smith'
    click_button 'Follow'
    click_link 'Unfollow'

    expect(page).to have_button("Follow")
    expect(page).to have_content('0')
  end
  scenario 'User cannot follow a user twice' do
    visit root_path
    click_link 'Denver Urban Steam'
    click_link 'John Smith'
    click_button 'Follow'

    expect(page).to_not have_content('Follow')
  end
  scenario 'User cannot follow a user if they are not logged in' do
    click_link 'Sign Out'
    visit root_path
    click_link 'Denver Urban Steam'
    click_link 'John Smith'

    expect(page).to_not have_button("Follow")
  end
  scenario 'User cannot follow themselves' do
    visit root_path
    click_link 'Isaac Tullis'

    expect(page).to_not have_button('Follow')
  end
end
