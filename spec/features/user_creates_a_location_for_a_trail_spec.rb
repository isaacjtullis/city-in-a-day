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
end
