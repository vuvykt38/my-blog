require 'rails_helper'

RSpec.describe Conversation, type: :model do
  context 'associations' do
    it 'has many messages' do
      expect(Conversation.new).to respond_to(:private_messages)
    end
  end
end
