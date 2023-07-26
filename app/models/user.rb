require "validator/email_validator"

class User < ApplicationRecord
  # Token生成モジュール
  include TokenGenerateService

  before_validation :downcase_email

  has_secure_password

  validates :name, presence: true,        #入力必須を表す
                   length: {              #文字数を検証する
                      maximum: 30,        #最大文字数
                      allow_blank: true   #Nullや空白文字のときは検証をスキップ
                   }

  validates :email, presence: true,
                    email: { allow_blank: true }

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

  ## methods
  # class method  ###########################
  class << self
    # emailからアクティブなユーザーを返す
    def find_by_activated(email)
      find_by(email: email, activated: true)
    end
  end
  # class method end #########################

  # 自分以外の同じemailのアクティブなユーザーがいる場合にtrueを返す
  def email_activated?
    users = User.where.not(id: id)
    users.find_by_activated(email).present?
  end

  # リフレッシュトークンのJWT IDを記憶する
  def remember(jti)
    update!(refresh_jti: jti)
  end

  # リフレッシュトークンのJWT IDを削除する
  def forget
    update!(refresh_jti: nil)
  end

  private

  # email小文字化
  def downcase_email
    self.email.downcase! if email
  end

end
