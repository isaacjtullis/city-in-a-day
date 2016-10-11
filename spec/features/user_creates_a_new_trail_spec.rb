require 'rails_helper'

feature 'User creates a new trail', %Q{
  As an urban explorer,
  I want to record an experience (location, activity),
  So that I can share things to do in a city.
} do

  scenario 'User fills out a form correctly' do
    visit root_path

    click_link 'Share Your Own Adventure'
    fill_in 'Name', with: 'Denver Urban Steam'
    fill_in 'Location', with: 'Denver, Colorado'
    fill_in 'Description', with: 'Urban Roast is wild!'
    select('10', :From => 'Price')
    select('Adventure', :from => 'Mood')
    click_button 'Make New Trail'

    expect(page).to have_content('Denver Urban Steam')
    expect(page).to have_content('Urban Roast wild!')
    expect(page).to have_content('10')
    expect(page).to have_content('Adventure')
  end
  scenario 'User fills out a form incorrectly'
  scenario 'User makes a description too long'
end
