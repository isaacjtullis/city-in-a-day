require "rails_helper"

feature "profile photo" do
  scenario "user uploads a profile photo" do
    visit root_path
    click_link "Sign Up"

    fill_in 'user_first_name', with: 'John'
    fill_in 'user_last_name', with: 'Smith'
    fill_in 'user_email', with: 'user@example.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    attach_file('Profile photo', "#{Rails.root}/spec/support/images/photo.png")
    click_button 'Sign Up'
    
    click_link 'John Smith'
    expect(page).to have_css("img[src*='photo.png']")
  end
end
