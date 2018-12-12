class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.references :game, foreign_key: true, index: true
      t.text :body
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
