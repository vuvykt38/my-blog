class PrivateMessage < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :conversation

  scope :unread, -> { where.not(read: true) }
  after_create :update_conversation_last_message

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
end
