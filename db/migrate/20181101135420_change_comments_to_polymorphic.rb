class ChangeCommentsToPolymorphic < ActiveRecord::Migration[5.2]
  def up
    remove_foreign_key :comments, :posts
    remove_index :comments, :post_id
    rename_column :comments, :post_id, :commentable_id
    add_column :comments, :commentable_type, :string
    add_index :comments, [:commentable_id, :commentable_type]
    Comment.update_all(commentable_type: 'Post')
  end

  def down
    Comment.transaction do
      remove_index :comments, [:commentable_id, :commentable_type]
      remove_column :comments, :commentable_type
      rename_column :comments, :commentable_id, :post_id
      add_index :comments, :post_id
      add_foreign_key :comments, :posts
    end
  end
end
