class Achievement < ApplicationRecord
  belongs_to :trophy, dependent: :destroy
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

  # Achievementモデル内のcompress_imageメソッド
  # def compress_image
  #   if image_url.attached?
  #     io = image_url.download

  #     image = MiniMagick::Image.read(io)
  #     image.resize "300x300"
  #     image.quality 80

  #     io = StringIO.new(image.to_blob)
  #     io.set_encoding(Encoding::BINARY)
  #     image_url.attach(io: io, filename: image_url.filename, content_type: "image/jpeg")
  #   end
  # end


end
