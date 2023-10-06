class AddColumnToPublicProfiles < ActiveRecord::Migration[6.1]
  def change
    add_column :public_profiles , :unique_hash, :string
  end
end
