class Conversation < ApplicationRecord
  has_many :private_messages
  has_many :user_conversations
  has_many :users, through: :user_conversations


  # TODO:  remove first_participate and second_participate when everyone migrated
  belongs_to :first_participate, class_name: 'User'
  belongs_to :second_participate, class_name: 'User'

  def self.conversation_for(user_id, other_id)
    Conversation.find_or_create_by(first_participate_id: [user_id, other_id].min,
                                   second_participate_id: [user_id, other_id].max)
  end
  ##################################################################################################

  belongs_to :last_message, class_name: 'PrivateMessage', foreign_key: 'last_message_id', optional: true

  scope :conversations_of, lambda { |user|
    where('second_participate_id = :user_id OR first_participate_id = :user_id',
          user_id: user.id).order(updated_at: :desc)
  }

  scope :unread, -> { where('user_conversations.unread = ?', true) }

  def other_user(current_user)
    (users.to_a - [current_user]).first
  end

  def message_time
    created_at.strftime("%b %d")
  end
end
