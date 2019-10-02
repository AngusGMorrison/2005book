class AddBirthdayHometownBooksToProfile < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :birthday, :datetime
    add_column :profiles, :hometown, :string
    add_column :profiles, :books, :string
  end
end
