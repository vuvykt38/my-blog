require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { build(:post) }

  subject { post }

  context 'associations' do
    it 'has many comments' do
      expect(subject.comments).to be_a(ActiveRecord::Associations::CollectionProxy)
    end

    it 'belongs to author' do
      expect(subject.author).to be_a(User)
    end

    it 'belongs to category' do
      expect(subject.category).to be_a(Category)
    end
  end

  context 'validation' do
    it 'is invalid if no title present' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'is invalid if no body present' do
      subject.body = nil
      expect(subject).to_not be_valid
    end

    it 'is invalid if no status present' do
      subject.status = nil
      expect(subject).to_not be_valid
    end

    it 'is invalid if no image present' do
      subject.image = nil
      expect(subject).to_not be_valid
    end
  end

  context 'scopes' do
    context '.posts_for' do
      let!(:post) { create(:post, status: 'public') }
      let!(:another_post) { create(:post, status: 'draft') }

      it 'return only 1 post for first author' do
        expect(Post.posts_for(post.author).to_a).to eq([post])
      end

      it 'return 2 posts for second author' do
        expect(Post.posts_for(another_post.author).count).to eq(2)
      end
    end

    context '.search_by' do
      let!(:post) { create(:post, title: '12345', body: 'lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
                                          tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
                                          quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
                                          consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
                                          cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
                                          proident, sunt in culpa qui officia deserunt mollit anim id est laborum.') }
      let!(:another_post) { create(:post, title: 'lorem', body: 'A paragraph (from the Ancient Greek παράγραφος paragraphos, "to write beside" or "written beside") is a self-contained unit of a discourse in writing dealing with a particular point or idea. A paragraph consists of one or more sentences') }
      it 'return posts include search keyword' do
        expect(Post.search_by('lorem').count).to eq(2)
        expect(Post.search_by('paragraph').count).to eq(1)
      end
    end
  end
end
