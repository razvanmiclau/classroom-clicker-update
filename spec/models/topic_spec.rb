require 'rails_helper'
require 'spec_helper'

describe Topic do
  it 'has a valid factory' do
    FactoryGirl.create(:topic).should be_valid
  end

  it 'should have a title' do
    FactoryGirl.build(:topic, title: nil).should_not be_valid
  end

  it 'should belong to a user' do
    topic = FactoryGirl.create(:topic)
    user = FactoryGirl.create(:user)
    user.topics << topic
    expect(topic.user).to be user
  end

  it 'should be unique' do
    topic1 = FactoryGirl.create(:topic)
    topic2 = FactoryGirl.create(:topic)
    topic1.should be_valid
    topic2.should_not be_valid
  end
end
