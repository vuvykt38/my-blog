class CreateUserConversations < ActiveRecord::Migration[5.2]
  def change
    create_table :user_conversations do |t|
      t.references :conversation, foreign_key: true, index: true
      t.references :user, foreign_key: true, index: true
      t.boolean :unread, default: true

      t.timestamps
    end
  end
end
