class AddTokenCreatedAtToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :token_created_at, :integer, default: 0
  end
end
