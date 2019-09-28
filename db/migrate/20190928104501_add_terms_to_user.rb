class AddTermsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :accepted_terms, :boolean, default: false
  end
end
