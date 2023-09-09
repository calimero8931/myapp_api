class CreateFriendships < ActiveRecord::Migration[6.1]
  def change
    create_table :friendships do |t|
      t.references :user, foreign_key:  { to_table: :users }
      t.references :friend, foreign_key: { to_table: :users }
      t.boolean :status, default: false

      t.timestamps
    end
  end
end