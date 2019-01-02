require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { build(:user) }
  let(:post) { build(:post) }

  subject { described_class.new(user: user, commentable: post) }
  context 'associations' do
    it 'belongs to User' do
      expect(subject.user).to be_a(User)
    end

    it 'belongs to commentable' do
      expect(subject.commentable).to be_a(Post)
    end

    it 'has many comment as commentable' do
      expect(subject.comments).to be_a(ActiveRecord::Associations::CollectionProxy)
    end
  end

  context '#notify_author' do
    let(:post) { create(:post) }

    it 'notifies author when someone comment on the post' do
      expect { create(:comment, commentable: post) }.to change { post.author.notifications.count }.by(1)
    end
  end
end