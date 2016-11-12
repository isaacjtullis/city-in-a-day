require 'rails_helper'

feature 'User creates a new trail', %Q{
  As an urban explorer,
  I want to record an experience (location, activity),
  So that I can share things to do in a city.
} do
  scenario 'Unregistered user cannot make a form' do
    visit root_path

    click_link 'Share Your Own Adventure'
    fill_in 'Name', with: 'Denver Urban Steam'
    fill_in 'Location', with: 'Denver, Colorado'
    fill_in 'Description', with: 'Urban Roast is wild!'
    select('10', :from => 'Price')
    select('Adventure', :from => 'Mood')
    click_button 'Make New Trail'

    expect(page).to have_content('You must be signed in')
    expect(page).to have_content('Sign In')
  end

  scenario 'User fills out a form correctly' do
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

    expect(page).to have_content('Denver Urban Steam')
    expect(page).to have_content('Urban Roast is wild!')
    expect(page).to have_content('10')
    expect(page).to have_content('Adventure')
    expect(page).to have_content('Congrats! You have made a new adventure.')
  end
  scenario 'User fills out a form incorrectly' do
    user = FactoryGirl.create(:user)

    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Sign In'
    visit root_path

    click_link 'Share Your Own Adventure'
    fill_in 'Name', with: ''
    fill_in 'Location', with: ''
    fill_in 'Description', with: ''
    select('10', :from => 'Price')
    select('Adventure', :from => 'Mood')
    click_button 'Make New Trail'
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Location can't be blank")
    expect(page).to have_content("Description can't be blank")
    expect(page).to have_content("Opps. We got some problems with that form")
  end
  scenario 'User makes a description too long' do
    user = FactoryGirl.create(:user)

    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Sign In'
    visit root_path

    click_link 'Share Your Own Adventure'
    fill_in 'Name', with: 'Denver Urban Steam'
    fill_in 'Location', with: 'Denver, Colorado'
    fill_in 'Description', with: 'This is going to be a very long Description
      because I do not want it to pass. It has to be over 140 char in length. This
      is now too long'
    select('10', :from => 'Price')
    select('Adventure', :from => 'Mood')
    click_button 'Make New Trail'

    expect(page).to have_content('Description is too long')
  end
end
