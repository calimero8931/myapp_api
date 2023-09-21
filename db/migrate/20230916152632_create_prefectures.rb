class CreatePrefectures < ActiveRecord::Migration[6.1]
  def change
    create_table :prefectures do |t|
      t.string :name
      t.references :region, foreign_key: { to_table: :regions }

      t.timestamps
    end
  end
end
