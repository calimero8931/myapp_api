class CreateRegions < ActiveRecord::Migration[6.1]
  def change
    create_table :regions do |t|
      t.string :name
      t.references :country, foreign_key: { to_table: :countries }

      t.timestamps
    end
  end
end
