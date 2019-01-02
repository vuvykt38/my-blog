FactoryBot.define do
  factory :post do
    association :author, factory: :user
    association :category, factory: :category
    title { 'Good morning' }
    status { 'public' }
    body { 'Hello' }
  end
end
