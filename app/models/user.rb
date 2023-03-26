class User < ApplicationRecord

  has_secure_password

  validates :name, presence: true,        #入力必須を表す
                   length: {              #文字数を検証する
                      maximum: 30,        #最大文字数
                      allow_blank: true   #Nullや空白文字のときは検証をスキップ
                   }
  VALID_PASSWORD_REGEX = /\A[\w\-]+\z/
  validates :password, presence: true,
                      length: { minimum: 8,
                        allow_blank: true
                      },
                      format: {
                        with: VALID_PASSWORD_REGEX,
                        message: :invalid_password,
                        allow_blank: true
                      },
                      allow_nil: true
end
