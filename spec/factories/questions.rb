require 'faker'

FactoryGirl.define do
  factory :question do
    title Faker::Lorem.sentence
    kind 'some-kind'
    uuid SecureRandom.uuid.gsub(/\-/,'')
  end
end
