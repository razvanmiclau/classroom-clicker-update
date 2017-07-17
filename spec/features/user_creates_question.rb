require 'rails_helper'
require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

feature 'User creates a question' do
  let(:user) { FactoryGirl.create(:user) }
  before { login_as(user, scope: :user) }
    scenario 'via the question form' do
      login_as(user, :scope => :user)
      topic = FactoryGirl.create(:topic)
      visit new_topic_question_path(topic.id)
      expect(page).to have_content("New Question")
      fill_in "question_title", with: 'How are you?'
      click_button 'Create Question'
      expect(Question.count).to eq(1)
    end
end
