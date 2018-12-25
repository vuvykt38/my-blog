class CopyDataFromConversationsToUserConversations < ActiveRecord::Migration[5.2]
  def up
    Conversation.find_each do |conversation|
      UserConversation.find_or_create_by(user: conversation.first_participate, conversation: conversation)
      UserConversation.find_or_create_by(user: conversation.second_participate, conversation: conversation)
    end
  end
end
