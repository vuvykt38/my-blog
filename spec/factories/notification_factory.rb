FactoryBot.define do
  factory :notification do
    association :user, factory: :user

    full_name { 'Some Name' }
    read { false }
  end
end
