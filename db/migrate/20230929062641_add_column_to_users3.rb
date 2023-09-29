class AddColumnToUsers3 < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :confirmation_token_expires_at, :datetime
  end
end
