include Rails.application.routes.url_helpers

class UserMailer < ApplicationMailer
  default from: 'trophees.dev@gmail.com'

  def signup_confirmation(user, email, confirmation_token, url)
    @user = user
    @email = email
    @confirmation_token = confirmation_token
    @url = url

    mail(to: @email, subject: 'Trophées新規ユーザー登録')
  end

  def password_reset(user, email, confirmation_token, url)
    @user = user
    @email = email
    @confirmation_token = confirmation_token
    @url = url

    mail(to: @email, subject: 'Trophéesパスワードリセット')
  end

  def email_change_confirmation(user, new_email, confirmation_token, url)
    @user = user
    @new_email = new_email
    @confirmation_token = confirmation_token
    @url = url

    mail(to: @new_email, subject: 'Trophéesメールアドレス変更の確認')
  end

  def send_contact_confirmation(name, email, contact)
    @name = name
    @email = email
    @contact = contact

    mail(to: @email, subject: 'Trophées お問い合わせ完了')
  end

end
