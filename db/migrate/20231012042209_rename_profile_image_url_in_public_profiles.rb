class RenameProfileImageUrlInPublicProfiles < ActiveRecord::Migration[6.1]
  def change
    rename_column :public_profiles, :profile__image_url, :profile_image_url
  end
end
