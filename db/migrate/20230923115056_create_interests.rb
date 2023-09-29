class CreateInterests < ActiveRecord::Migration[6.1]
  def change
    create_table :interests do |t|
      t.references :user, foreign_key: { to_table: :users }, null: false
      t.references :sub_category, foreign_key: { to_table: :sub_categories }, null: false
      t.timestamps
    end
  end
end
