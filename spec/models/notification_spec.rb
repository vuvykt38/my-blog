require 'rails_helper'

RSpec.describe Notification, type: :model do
  let(:user) { build(:user) }

  subject { described_class.new(user: user) }

  context 'associations' do
    it 'belongs to user' do
      expect(subject.user).to be_a(User)
    end
  end

  context 'scopes' do
    context '#unread' do
      let!(:read_notification) { create(:notification, user: user, read: true) }
      let!(:unread_notification) { create(:notification, user: user, read: false) }

      it 'returns unread notifications' do
        expect(Notification.unread).to eq([unread_notification])
      end
    end
  end
end
