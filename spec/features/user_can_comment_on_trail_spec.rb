require 'rails_helper'

feature 'User comments on a trail', %Q{
  As an urban explorer,
  I want to comment on a trail,
  So that I can engage with other users.
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
end
