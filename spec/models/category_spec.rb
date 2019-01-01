require 'rails_helper'

RSpec.describe Category, type: :model do
  subject { Category.new }

  context 'associations' do
    it 'has many posts' do
      expect(subject).to respond_to(:posts)
      expect(subject.posts).to be_a(ActiveRecord::Associations::CollectionProxy)
    end
  end

  context 'validations' do
    context 'requires name' do
      it 'is invalid if no name present' do
        expect(subject.valid?).to eq(false)
        expect(subject.errors[:name]).to include("can't be blank")
      end
    end
  end
end
