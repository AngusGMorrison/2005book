class AddUserColumnsToFriendships < ActiveRecord::Migration[6.0]
  def change
    add_column :friendships, :user_1_id, :integer
    add_column :friendships, :user_2_id, :integer
  end
end
