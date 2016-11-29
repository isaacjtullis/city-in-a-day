require 'rails_helper'

feature 'User has a profile', %Q{
  As an Urban Explorer
  I want to fill in my profile
  So people can easily find me, follow me and can engage with me
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
    select('Adventure', :from => 'What was the mood of your adventure?')
    click_button 'Make New Trail'

    fill_in 'Name of Location', with: 'Denver, Colorado'
    fill_in 'Where was it?', with: 'Urban Roast is wild!'
    fill_in 'Tell us a little bit about it:', with: 'Bring cash!'
    select('10', :from => 'What was the price?')
    click_button 'Make New Location'
  end

  scenario 'As a an authenticated user, they can see their information' do

    visit root_path

    click_link 'John Smith'
    expect(page).to have_content("John Smith")
    expect(page).to have_content("Home City")
    expect(page).to have_content("Favorite City")
  end
  scenario 'A user can see all the trails they made' do

    visit root_path
    click_link 'John Smith'

    expect(page).to have_content("Denver Urban Steam")
  end
  scenario 'A user can update their information' do
    visit root_path
    click_link 'John Smith'
    click_link 'Edit'

    fill_in 'Bio', with: 'I really enjoy exploring the outdoors!'
    click_button 'Update'

    expect(page).to have_content('I really enjoy exploring the outdoors!')
  end
  scenario 'A user can change their password' do
    visit root_path
    click_link 'John Smith'
    click_link 'Change Password'

    fill_in 'Password', with: 'Password'
    fill_in 'Password confirmation', with: 'Password'
    fill_in 'Current password', with: 'password'

    click_button 'Update'

    expect(page).to have_content("Your account has been updated successfully.")
  end

  scenario 'A user can change their picture' do
    visit root_path
    click_link 'John Smith'
    click_link 'Edit Profile'

    attach_file('Profile photo', "#{Rails.root}/spec/support/images/photo.png")
    click_button 'Update'

    expect(page).to have_css("img[src*='photo.png']")
  end
end
