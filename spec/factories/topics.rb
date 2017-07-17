require 'faker'

FactoryGirl.define do
  factory :topic do
    title Faker::Lorem.characters(5)
  end
end
