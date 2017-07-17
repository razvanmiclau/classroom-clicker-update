require 'rails_helper'
require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

feature 'User creates a topic' do
  let(:user) { FactoryGirl.create(:user) }
  before { login_as(user, scope: :user) }
    scenario 'via the topic form from the dashboard' do
      login_as(user, :scope => :user)
      visit new_topic_path
      expect(page).to have_content("New Topic")
      fill_in "topic_title", with: 'Informatics'
      click_button 'Create Topic'
      expect(Topic.count).to eq(1)
    end
end
