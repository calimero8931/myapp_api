class Achievement < ApplicationRecord
  belongs_to :trophy
  has_one_attached :image_url

  public

  def achievements_image
    if image_url.attached?
      # アタッチメントが存在する場合の処理
      Rails.application.routes.url_helpers.rails_blob_path(image_url, only_path: false)
    else
      # 画像がアタッチされていない場合のデフォルトのアタッチメントを返す
      # ここでデフォルトのアタッチメントを設定してください
      # 例: default_profile_image.png がアタッチされている場合
      # Rails.application.routes.url_helpers.rails_blob_path("default_profile_image.png", only_path: false)
    end
  end

end
