require 'rails_helper'

feature 'User creates a location for a trail', %Q{
  As an urban explorer,
  I want to add locations to a trail,
  So that I can personalize a trail.
} do
  scenario 'Unregistered user cannot make a form' do
    visit root_path

    visit root_path

    click_link 'Share Your Own Adventure'
    fill_in 'Name', with: 'Denver Urban Steam'
    select('Adventure', :from => 'What was the mood of your adventure?')
    click_button 'Make New Trail'

    expect(page).to have_content('You must be signed in')
    expect(page).to have_content('Sign In')
  end
end
