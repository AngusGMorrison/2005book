class ChangeProfilePoliticalViewsToId < ActiveRecord::Migration[6.0]
  def change
    remove_column :profiles, :political_views
    add_column :profiles, :political_view_id, :integer
  end
end
