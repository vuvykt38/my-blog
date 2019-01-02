FactoryBot.define do
  factory :comment do
    association :user, factory: :user
    commentable { |c| c.association(:post) }

    body { 'Hello' }
  end
end
