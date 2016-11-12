require 'rails_helper'

feature 'sign up', %Q{
  As a prospective Urban Explorer
  I want to create an account
  So that I can post items and review them
} do

  scenario 'specifying valid information and required information' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'user_first_name', with: 'John'
    fill_in 'user_last_name', with: 'Smith'
    fill_in 'user_email', with: 'user@example.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    click_button 'Sign Up'

    expect(page).to have_content("You're In!")
    expect(page).to have_content("Sign Out")
  end

  scenario 'required information is not supplied' do
    visit root_path
    click_link 'Sign Up'
    click_button 'Sign Up'

    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content("Sign Out")
  end
  scenario 'password confirmation does not match configuration' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'user_first_name', with: 'John'
    fill_in 'user_last_name', with: 'Smith'
    fill_in 'user_email', with: 'user@example.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'wrongpassword'
    click_button 'Sign Up'

    expect(page).to have_content("doesn't match Password")
    expect(page).to_not have_content("Sign Out")
  end
end
