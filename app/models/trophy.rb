class Trophy < ApplicationRecord
  has_many :achievements, dependent: :destroy
  belongs_to :prefecture
  has_one_attached :image_url

  public

  def profile_image
    if image_url.attached?
      # アタッチメントが存在する場合の処理
      Rails.application.routes.url_helpers.rails_blob_path(image_url, only_path: false)
    else
      # 画像がアタッチされていない場合のデフォルトのアタッチメントを返す
      'noimage.png'
    end
  end
end