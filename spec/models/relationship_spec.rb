require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:follower) { build(:user) }
  let(:followed) { build(:user) }

  subject { described_class.new(follower: follower, followed: followed) }

  context 'associations' do
    it 'belongs to follower' do
      expect(subject.follower).to be_a(User)
    end

    it 'belongs to followed' do
      expect(subject.followed).to be_a(User)
    end
  end
end
