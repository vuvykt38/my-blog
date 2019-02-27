require 'ffaker'

FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password { FFaker::Internet.password }
    full_name { FFaker::Name.name }
  end
end
