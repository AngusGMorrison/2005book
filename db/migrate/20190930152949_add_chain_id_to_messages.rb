class AddChainIdToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :chain_id, :integer
  end
end
