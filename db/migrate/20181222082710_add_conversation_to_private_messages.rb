class AddConversationToPrivateMessages < ActiveRecord::Migration[5.2]
  def change
    add_reference :private_messages, :conversation, foreign_key: true
  end
end
