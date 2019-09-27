class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, default: nil
      t.string :password_digest, default: nil
      t.integer :mod_id, default: nil
      t.string :sex , default: nil
      t.string :studies, default: nil
      t.string :phone_number, default: nil
      t.string :screenname, default: nil
      t.string :looking_for, default: nil
      t.string :interested_in, default: nil
      t.string :relationship_status, default: nil
      t.string :political_views, default: nil
      t.string :interests, default: nil
      t.string :movies, default: nil
      t.string :music, default: nil
      t.string :websites, default: nil
      t.string :about_me, default: nil
      t.string :photo_url, default: nil
      t.timestamps
    end
  end
end
