require 'rails_helper'
require 'spec_helper'

feature 'User logs in' do
  scenario 'via email and password through the sign-in form' do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    expect(page).to have_content("Email")
    expect(page).to have_content("Password")

    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_button "Log in"
    expect(session[:user_id]).to_not be_nil
  end
end
