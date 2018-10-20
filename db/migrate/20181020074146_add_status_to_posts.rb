class AddStatusToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :status, :string
    add_index :posts, :status
  end
end
