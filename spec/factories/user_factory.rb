require 'ffaker'

FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password '123456'
    full_name { FFaker::Name.name }
  end
end
