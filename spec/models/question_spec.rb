require 'rails_helper'
require 'spec_helper'

describe Question do
  it 'has a valid factory' do
    FactoryGirl.create(:question).should be_valid
  end

  it 'should have a title' do
    FactoryGirl.build(:question, title: nil).should_not be_valid
  end

  it 'should have a UUID' do
    question = FactoryGirl.create(:question)
    expect(question.uuid).not_to be_empty
  end

  it 'should belong to a topic' do
    question = FactoryGirl.create(:question)
    topic = FactoryGirl.create(:topic)
    topic.questions << question
    expect(question.topic).to be topic
  end

  it 'should be unique' do
    question1 = FactoryGirl.create(:question)
    question2 = FactoryGirl.create(:question)
    question1.should be_valid
    question2.should_not be_valid
  end
end
