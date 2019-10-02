class RemoveColumnsFromFriendships < ActiveRecord::Migration[6.0]
  def change
    remove_column :friendships, :status
    remove_column :friendships, :user_id
    remove_column :friendships, :friend_id
  end
end
