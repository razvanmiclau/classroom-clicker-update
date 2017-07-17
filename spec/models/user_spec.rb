require 'rails_helper'
require 'spec_helper'

describe User do
  it 'has a valid factory' do
    FactoryGirl.create(:user).should be_valid
  end

  it 'should have a first_name' do
    FactoryGirl.build(:user, first_name: nil).should_not be_valid
  end

  it 'should have a last_name' do
    FactoryGirl.build(:user, last_name: nil).should_not be_valid
  end

  it 'should have an email' do
    FactoryGirl.build(:user, email: nil).should_not be_valid
  end

  it 'should have a valid email' do
    email = 'razvan.miclau@gmail.com'
    FactoryGirl.build(:user, email: email)
    regular_expression = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    expect(email).to match regular_expression
  end

  it 'should have a unique email' do
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    user1.should be_valid
    user2.should_not have_valid(:email)
  end

  it 'is invalid without a password' do
    FactoryGirl.build(:user, password: nil).should_not be_valid
  end
end
