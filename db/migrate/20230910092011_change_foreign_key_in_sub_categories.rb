class ChangeForeignKeyInSubCategories < ActiveRecord::Migration[6.1]
  def change
    # remove_foreign_key :trophies, :categories, column: :category_id
    add_foreign_key :trophies, :sub_categories, column: :category_id
  end
end
