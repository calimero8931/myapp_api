class CreateTrophies < ActiveRecord::Migration[6.1]
  def change
    create_table :trophies do |t|
      t.references :category, foreign_key: { to_table: :sub_categories }
      t.string :title
      t.text :description
      t.references :create_user, foreign_key: { to_table: :users }
      t.string :image_url

      t.timestamps
    end
  end
end
