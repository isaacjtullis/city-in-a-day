require 'rails_helper'

feature 'User comments on a trail', %Q{
  As an urban explorer,
  I want to comment on a trail,
  So that I can engage with other users.
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

    user1 = FactoryGirl.create(:user)

    visit new_user_session_path
    fill_in 'user_email', with: user1.email
    fill_in 'user_password', with: user1.password
    click_button 'Sign In'

  end

  scenario 'User comments on a trail' do
    visit root_path

    click_link 'Denver Urban Steam'

    fill_in 'Description', with: "This place sucks."
    click_button 'Create Comment'

    expect(page).to have_content('Denver, Colorado')
    expect(page).to have_content('Urban Roast is wild!')
    expect(page).to have_content('This place sucks.')
  end

  scenario 'User does not fill in description correctly' do
    visit root_path

    click_link 'Denver Urban Steam'

    fill_in 'Description', with: ""
    click_button 'Create Comment'

    expect(page).to have_content('Denver, Colorado')
    expect(page).to have_content('Urban Roast is wild!')
    expect(page).to have_content('Comment was not saved!')
  end
  scenario 'User is not signed in' do
    visit root_path
    click_link 'Sign Out'

    visit root_path
    click_link 'Denver Urban Steam'
    click_button 'Create Comment'

    expect(page).to have_content('You must be logged in to comment!')
  end
end
