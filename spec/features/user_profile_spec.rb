require 'rails_helper'

feature 'User has a profile', %Q{
  As an Urban Explorer
  I want to fill in my profile
  So people can easily find me, follow me and can engage with me
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
  end
  scenario 'As a an authenticated user, they can see their information' do

    visit root_path

    click_link 'John Smith'
    expect(page).to have_content("Welcome! John Smith")
    expect(page).to have_content("Home City")
    expect(page).to have_content("Favorite City")
  end
  scenario 'A user can see all the trails they made' do

    visit root_path
    click_link 'John Smith'

    expect(page).to have_content("Denver Urban Steam")
    expect(page).to have_content("Denver, Colorado")
  end
  scenario 'A user can update their information' do
    visit root_path
    click_link 'John Smith'
    click_link 'Edit'

    fill_in 'Bio', with: 'I really enjoy exploring the outdoors!'
    click_button 'Update'

    expect(page).to have_content('I really enjoy exploring the outdoors!')
  end
end
