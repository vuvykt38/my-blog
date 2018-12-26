class Conversation < ApplicationRecord
  has_many :private_messages
  has_many :user_conversations
  has_many :users, through: :user_conversations

  # TODO:  remove first_participate and second_participate when everyone migrated
  belongs_to :first_participate, class_name: 'User', optional: true
  belongs_to :second_participate, class_name: 'User', optional: true

  def self.conversation_for(user_id, other_id)
    Conversation.find_or_create_by(first_participate_id: [user_id, other_id].min,
                                   second_participate_id: [user_id, other_id].max)
  end
  ##################################################################################################

  belongs_to :last_message, class_name: 'PrivateMessage', foreign_key: 'last_message_id', optional: true

  scope :conversations_of, lambda { |user|
    Conversation
      .joins(:user_conversations)
      .where('user_conversations.user_id = ?', user.id)
      .order(updated_at: :desc)
  }

  scope :between, lambda { |user_id, other_user_id|
    Conversation
      .joins('INNER JOIN user_conversations uc1 on (uc1.conversation_id = conversations.id)')
      .joins('INNER JOIN user_conversations uc2 on (uc2.conversation_id = conversations.id)')
      .where('uc1.user_id = ?', user_id)
      .where('uc2.user_id = ?', other_user_id)
  }

  scope :unread, -> { where('user_conversations.unread = ?', true) }

  def other_user(current_user)
    (users.to_a - [current_user]).first
  end

  def message_time
    created_at.strftime("%b %d")
  end
end
