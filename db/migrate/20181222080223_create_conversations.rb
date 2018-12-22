class CreateConversations < ActiveRecord::Migration[5.2]
  def change
    create_table :conversations do |t|
      t.references :first_participate, index: true, foreigner_key: { to_table: :users }
      t.references :second_participate, index: true, foreigner_key: { to_table: :users }
      t.references :last_message, index: true, foreigner_key: { to_table: :private_messages }

      t.timestamps
    end
  end
end
