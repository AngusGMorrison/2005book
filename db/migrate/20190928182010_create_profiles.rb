class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :sex
      t.string :studies
      t.string :phone_number
      t.string :screenname
      t.string :looking_for
      t.string :interested_in
      t.string :relationship_status
      t.string :political_views
      t.string :interests
      t.string :movies
      t.string :music
      t.string :websites
      t.string :about_me
      t.string :photo_url
    end
  end
end
