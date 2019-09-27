class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.string :description
      t.integer :admin_id, default: nil
      t.string :photo_url, default: nil
      t.timestamps
    end
  end
end
