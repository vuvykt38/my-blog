class PrivateMessage < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :conversation

  scope :unread, -> { where.not(read: true) }
  after_create :update_conversation_last_message, :update_conversation_unread

  def message_time
    created_at.strftime("%b %d")
  end

  def message_hour
    created_at.strftime("%I:%M %p")
  end

  private

  def update_conversation_last_message
    conversation.update(last_message: self)
  end

  def update_conversation_unread
    UserConversation.find_by(user: conversation.other_user(sender),
                             conversation: conversation).update(unread: true)
  end
end
