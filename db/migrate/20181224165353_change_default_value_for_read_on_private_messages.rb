
class ChangeDefaultValueForReadOnPrivateMessages < ActiveRecord::Migration[5.2]
  def change
    change_column_default :private_messages, :read, from: true, to: false
  end
end
