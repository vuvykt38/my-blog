class UpdateConversationDataForPrivateMessages < ActiveRecord::Migration[5.2]
  def up
    PrivateMessage.find_each do |message|
      conversation = Conversation.conversation_for(message.sender_id, message.receiver_id)
      message.update(conversation: conversation)
      conversation.update(last_message: message)
    end
  end

  def down
    PrivateMessage.update_all(conversation_id: nil)
  end
end
