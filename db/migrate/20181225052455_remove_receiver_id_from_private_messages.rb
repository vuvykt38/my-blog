class RemoveReceiverIdFromPrivateMessages < ActiveRecord::Migration[5.2]
  def change
    remove_reference :private_messages, :receiver, index: true, foreigner_key: { to_table: :users }
  end
end
