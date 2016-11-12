require 'rails_helper'

feature 'User searches for a trail', %Q{
  As an urban explorer,
  I want to find a trail,
  So that I can look at previously made trails .
} do
    before do
      user = FactoryGirl.create(:user)

      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Sign In'

      visit root_path

      click_link 'Share Your Own Adventure'
      fill_in 'Name', with: 'Denver Urban Steam'
      fill_in 'Location', with: 'Denver, Colorado'
      fill_in 'Description', with: 'Urban Roast is wild!'
      select('10', :from => 'Price')
      select('Adventure', :from => 'Mood')
      click_button 'Make New Trail'
    end
  scenario 'user searches for a previously made trail' do
    visit root_path
    fill_in 'search', with: 'Denver Urban Steam'
    click_button 'Search'

    expect(page).to have_content('Denver, Colorado')
    expect(page).to have_content('Denver Urban Steam')
  end

  scenario 'user searches for a trail that does not exist' do
    visit root_path
    fill_in 'search', with: 'Looking for a trail'
    click_button 'Search'

    expect(page).to have_content('Sorry, we cannot find what you are looking for')
  end
end
