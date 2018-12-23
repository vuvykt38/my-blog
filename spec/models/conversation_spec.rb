require 'rails_helper'

RSpec.describe Conversation, type: :model do
  it 'has associations' do
    expect(Conversation.new).to respond_to(:private_messages)
    expect(Conversation.new).to respond_to(:first_participate)
    expect(Conversation.new).to respond_to(:second_participate)
  end

  # context 'conversation_for' do
  #   it 'has conversation_for with 2 params' do
  #     expect { Conversation.conversation_for(1, 2) }.not_to raise_error
  #   end

  #   it 'returns a conversation' do
  #     expect(Conversation.conversation_for(1, 2)).to be_a(Conversation)
  #   end

  #   context 'saves participators' do
  #     let!(:first_user) { User.create(full_name: 'User 1') }
  #     let!(:second_user) { User.create(full_name: 'User 2') }

  #     it 'saves the conversation' do
  #       expect(Conversation.conversation_for(1, 2).id).to be_present
  #     end

  #     it 'saves the participate' do
  #       expect(Conversation.conversation_for(first_user.id, second_user.id).first_participate).to eq(first_user)
  #     end
  #   end
  # end
end
