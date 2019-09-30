class CreateProfileLookingForOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :profile_looking_for_options do |t|
      t.integer :profile_id
      t.integer :looking_for_option_id
      t.timestamps
    end
  end
end
