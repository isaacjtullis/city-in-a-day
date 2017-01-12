require 'rails_helper'

feature 'User creates a new trail', %Q{
  As an urban explorer,
  I want to record an experience (location, activity),
  So that I can share things to do in a city.
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
  scenario 'User fills out a form correctly' do
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

    expect(page).to have_content('Denver Urban Steam')
    expect(page).to have_content('Urban Roast is wild!')
    expect(page).to have_content('10')
    expect(page).to have_content('Adventure')
    expect(page).to have_content('Congrats! Location saved')
  end
  scenario 'User fills out the form with a photo' do
    user = FactoryGirl.create(:user)

    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Sign In'

    visit root_path

    click_link 'Share Your Own Adventure'
    fill_in 'trail_name', with: 'Denver Urban Steam'
    select('Adventure', :from => 'trail_mood')
    attach_file('trail_trail_photo', "#{Rails.root}/spec/support/images/photo.png")
    click_button 'Submit'

    fill_in 'location_name', with: 'Denver, Colorado'
    fill_in 'location_location', with: 'Urban Roast is wild!'
    fill_in 'location_description', with: 'Bring cash!'
    select('10', :from => 'location_price')
    click_button 'Make New Location'

    visit root_path

    expect(page).to have_css("img[src*='photo.png']")
  end
  scenario 'User fills out a form incorrectly' do
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

    fill_in 'location_name', with: ''
    fill_in 'location_location', with: ''
    fill_in 'location_description', with: ''
    select('10', :from => 'location_price')
    click_button 'Make New Location'


    expect(page).to have_content("can't be blank")
    expect(page).to have_content("can't be blank")
    expect(page).to have_content("can't be blank")
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
    fill_in 'trail_name', with: 'Denver Urban Steam'
    select('Adventure', :from => 'trail_mood')
    click_button 'Submit'

    fill_in 'location_name', with: 'Denver, Colorado'
    fill_in 'location_location', with: 'Urban Roast is wild!'
    fill_in 'location_description', with: 'This is going to be a very long Description
      because I do not want it to pass. It has to be over 140 char in length. This
      is now too long'
    select('10', :from => 'location_price')
    click_button 'Make New Location'

    expect(page).to have_content('is too long')
  end
end
