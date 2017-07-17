require 'rails_helper'
require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

feature 'User answers a question' do
    scenario 'via the answer form' do
      topic = FactoryGirl.create(:topic)
      question = FactoryGirl.create(:question)
      visit new_topic_question_answer_path(topic.id, question.id)
      expect(page).to have_content('ANSWERS')
      fill_in "answer_value", with: 'sample answer'
      click_button 'Submit'
      expect(Answer.count).to eq(1)
    end
end
