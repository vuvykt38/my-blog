class CreatePrivateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :private_messages do |t|
      t.text :body
      t.references :sender, index: true, foreigner_key: { to_table: :users }
      t.references :receiver, index: true, foreigner_key: { to_table: :users }
      t.boolean :read, default: :true

      t.timestamps
    end
  end
end
