class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.string :status, default: nil
      t.integer :user_id #person who makes the friend request
      t.integer :friend_id #person who accepts the friend request
    end
  end
end
