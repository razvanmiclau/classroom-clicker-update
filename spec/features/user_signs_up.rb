require 'rails_helper'
require 'spec_helper'

feature 'User signs up' do
  scenario 'via email and password through the sign-up form' do
    visit new_user_registration_path
    expect(page).to have_content("First name")
    expect(page).to have_content("Last name")
    expect(page).to have_content("Email")
    expect(page).to have_content("Password")
    expect(page).to have_content("Password confirmation")
    fill_in "user_first_name", with: Faker::Name.first_name
    fill_in "user_last_name", with: Faker::Name.last_name
    fill_in "user_email", with: Faker::Internet.email
    fill_in "user_password", with: 'adminPass'
    fill_in "user_password_confirmation", with: 'adminPass'
    click_button "Sign up"
    expect(User.count).to eq(1)
  end
end
