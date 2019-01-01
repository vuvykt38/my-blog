FactoryBot.define do
  factory :relationship do
    association :follower, :followed, factory: :user
  end
end
