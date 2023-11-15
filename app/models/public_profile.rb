class PublicProfile < ApplicationRecord
  belongs_to :user
  has_one_attached :profile_image_url

  public

  def profile_image
    if profile_image_url.attached?
      Rails.application.routes.url_helpers.rails_blob_path(profile_image, only_path: false)
    else
      # 画像がアタッチされていない場合のデフォルトの画像パスを返すか、エラー処理を行う
      # 例: "/images/default_profile_image.png"
      nil
    end
  end
end
