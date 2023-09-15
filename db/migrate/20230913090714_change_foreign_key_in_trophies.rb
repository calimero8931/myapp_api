class ChangeForeignKeyInTrophies < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :trophies, column: :category_id, to_table: :sub_categories

    add_foreign_key :trophies, :sub_categories, column: :category_id, primary_key: :id
  end
end
