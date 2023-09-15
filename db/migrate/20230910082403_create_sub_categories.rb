class CreateSubCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :sub_categories do |t|
      t.references :category, foreign_key: { to_table: :categories }
      t.string :name

      t.timestamps
    end
  end
end
