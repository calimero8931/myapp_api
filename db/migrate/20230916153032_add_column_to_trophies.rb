class AddColumnToTrophies < ActiveRecord::Migration[6.1]
  def change
    add_column :trophies, :latitude, :decimal, precision: 10, scale: 6
    add_column :trophies, :longitude, :decimal, precision: 10, scale: 6
    add_reference :trophies, :country, foreign_key: { to_table: :countries }
    add_reference :trophies, :region, foreign_key: { to_table: :regions }
    add_reference :trophies, :prefecture, foreign_key: { to_table: :prefectures }

  end
end
