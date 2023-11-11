class RemoveUniqueConstraintFromPublicProfilesUsername < ActiveRecord::Migration[6.1]
  def change
    remove_index :public_profiles, :username
    add_index :public_profiles, :username
  end
end
