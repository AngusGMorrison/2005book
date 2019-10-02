class CreateLookingForOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :looking_for_options do |t|
      t.string :name
      t.timestamps
    end
  end
end
