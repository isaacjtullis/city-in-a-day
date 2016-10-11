require 'rails_helper'

feature 'sign up', %Q{
  As a prospective Urban Explorer
  I want to create an account
  So that I can post items and review them
} do

  scenario 'specifying valid information and required information' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'First Name', with: 'John'
    fill_in 'Last Name', with: 'Smith'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Confirmation', with: 'password'
    click_button 'Sign Up'

    expect(page).to have_content("You're In!")
    expect(page).to have_content("Sign Out")
  end

  scenario 'required information is not supplied'
  scenario 'password confirmation does not match configuration'
end
