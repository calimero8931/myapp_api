class AddColumnToUsers2 < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :confirmation_token, :string
  end
end
