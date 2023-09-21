class CreateAchievements < ActiveRecord::Migration[6.1]
  def change
    create_table :achievements do |t|
      t.references :user, foreign_key: { to_table: :users }
      t.references :trophy, foreign_key: { to_table: :trophies }
      t.boolean :favorite, default: false
      t.boolean :achievement, default: false
      t.datetime :success_at
      t.string :image_url

      t.timestamps
    end
  end
end
