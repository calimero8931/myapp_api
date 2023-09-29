include Rails.application.routes.url_helpers

class UserMailer < ApplicationMailer
  default from: 'test@test.com' # 送信元のメールアドレスを設定

  def email_change_confirmation(user, new_email, confirmation_token, url)
    @user = user
    @new_email = new_email
    @confirmation_token = confirmation_token
    @url = url


    # メールの送信先、件名、本文を設定
    mail(to: @new_email, subject: 'Trophéesメールアドレス変更の確認')
  end

end
