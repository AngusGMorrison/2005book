class CreateGroupUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :group_users do |t|
      t.integer :group_id
      t.integer :user_id
    end
  end
end
