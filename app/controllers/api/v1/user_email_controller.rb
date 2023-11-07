class Api::V1::UserEmailController < ApplicationController

  def request_change
    user_id = params[:params][:user_id]
    new_email = params[:params][:new_email]
    user = User.find_by(id: user_id)
    another_user = User.find_by(email: new_email)

    if user.nil?
      render json: { error: 'ユーザーが見つかりません' }, status: :not_found
      return
    end

    if another_user.present?
      render json: { error: '既に登録されているメールアドレスです' ,message: '既に登録されているメールアドレスです' }, status: :unprocessable_entity
      return
    end

    confirmation_token = SecureRandom.urlsafe_base64
    confirmation_token_expires_at = 5.minutes.from_now # 5分後
    user.update(
      unconfirmed_email: new_email,
      confirmation_token: confirmation_token,
      confirmation_token_expires_at: confirmation_token_expires_at
      )

    # url = "http://localhost:8080/confirm_email/#{user_id}/#{confirmation_token}?format=json"
    url = api_v1_confirm_email_change_url(id: user_id, token: confirmation_token)

    UserMailer.email_change_confirmation(user, new_email, confirmation_token, url).deliver_now

    render json: { message: 'メールが送信されました。' }
  end

  def confirm_email_change_step1
    id = params[:id]
    token = params[:token]
    redirect_to "https://animal-app-front.herokuapp.com/account/mail-address?id=#{id}&token=#{token}"
  end

  def confirm_email_change_step2
    user_id = params[:user_id]
    token = params[:token]

    user = User.find_by(id: user_id)

    if user.nil?
      render json: { error: nil , message: 'ユーザーが見つかりません' }, status: :unprocessable_entity
      return
    end

    # トークンの有効期限をチェック
    if user.confirmation_token_expired?
      user.update(unconfirmed_email: nil, confirmation_token: nil, confirmation_token_expires_at: nil)
      render json: { error: nil , message: 'トークンの有効期限が切れています' }, status: :unprocessable_entity
      return
    end

    if user.confirmation_token == token
      user.update(email: user.unconfirmed_email, unconfirmed_email: nil, confirmation_token: nil, confirmation_token_expires_at: nil)
      render json: { message: 'メールアドレスが更新されました' }
    else
      user.update(unconfirmed_email: nil, confirmation_token: nil, confirmation_token_expires_at: nil)
      render json: { error: nil ,message: '無効なトークンです。もう一度やり直してください。' }, status: :unprocessable_entity
    end
  end

  def send_contact_confirmation
    name = params[:user][:name]
    email = params[:user][:email]
    content = params[:user][:content]

    UserMailer.send_contact_confirmation(name, email, content).deliver_now

    render json: { message: 'メールが送信されました。' }
  end

end
