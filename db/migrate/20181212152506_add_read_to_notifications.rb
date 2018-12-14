class AddReadToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :read, :boolean, index: true
  end
end
