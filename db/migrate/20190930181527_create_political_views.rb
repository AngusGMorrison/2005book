class CreatePoliticalViews < ActiveRecord::Migration[6.0]
  def change
    create_table :political_views do |t|
      t.string :name
      t.timestamps
    end
  end
end
