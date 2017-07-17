require 'rails_helper'
require 'spec_helper'

describe Answer do
  it 'has a valid factory' do
    FactoryGirl.create(:answer).should be_valid
  end

  it 'should have a value' do
    FactoryGirl.build(:answer, value: nil).should_not be_valid
  end

  it 'should belong to a question' do
    question = FactoryGirl.create(:question)
    answer = FactoryGirl.create(:answer)
    question.answers << answer
    expect(answer.question).to be question
  end
end
