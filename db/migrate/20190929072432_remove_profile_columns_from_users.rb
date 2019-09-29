class RemoveProfileColumnsFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :sex
    remove_column :users, :studies
    remove_column :users, :phone_number
    remove_column :users, :screenname
    remove_column :users, :looking_for
    remove_column :users, :interested_in
    remove_column :users, :relationship_status
    remove_column :users, :political_views
    remove_column :users, :interests
    remove_column :users, :movies
    remove_column :users, :music
    remove_column :users, :websites
    remove_column :users, :about_me
    remove_column :users, :photo_url
  end
end
