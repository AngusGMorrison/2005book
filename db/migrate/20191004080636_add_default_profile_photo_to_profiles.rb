class AddDefaultProfilePhotoToProfiles < ActiveRecord::Migration[6.0]
  def change
    change_column :profiles, :photo_url, :string, :default => "http://www.baytekent.com/wp-content/uploads/2016/12/facebook-default-no-profile-pic1-600x600.jpg"
  end
end
