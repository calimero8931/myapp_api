class CreatePublicProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :public_profiles do |t|
      t.references :user, foreign_key: { to_table: :users }, null: false
      t.string :username, null: false
      t.string :profile__image_url
      t.text :bio
      t.string :website
      t.timestamps
    end
    add_index :public_profiles, :username, unique: true
  end
end
