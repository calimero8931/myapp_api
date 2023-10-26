class Api::V1::UserPasswordController < ApplicationController
  require 'bcrypt'
  def request_change
    user_id = params[:params][:user_id]
    old_password = params[:params][:old_password]
    new_password = params[:params][:new_password]
    user = User.find(user_id)

    if user.nil?
      render json: { message: "ユーザーが見つかりませんでした" }, status: :unprocessable_entity
    end

    if user.authenticate(old_password)
      user.update(password_digest: BCrypt::Password.create(new_password))
      render json: { message: "パスワードが変更されました" }, status: :ok
    else
      render json: { error: nil ,message: "現在のパスワードが違います" }, status: :unprocessable_entity

    end
  end

  def password_reset_step1
    email = params[:params][:email]

    user = User.find_by(email: email)

    if user.nil?
      render json: { error: 'ユーザーが見つかりません' }, status: :not_found
      return
    end

    confirmation_token = SecureRandom.urlsafe_base64
    confirmation_token_expires_at = 5.minutes.from_now # 5分後
    user.update(
      confirmation_token: confirmation_token,
      confirmation_token_expires_at: confirmation_token_expires_at
      )

    url = api_v1_password_reset_url(token: confirmation_token)

    UserMailer.password_reset(user, email, confirmation_token, url).deliver_now

    render json: { message: 'メールが送信されました。' }
  end

  def password_reset_step2
    token = params[:token]
    redirect_to "http://localhost:8080/password-reset?token=#{token}"
  end

  def password_reset_step3
    token = params[:params][:token]
    password = params[:params][:new_password]

    user = User.find_by(confirmation_token: token)

    if user.nil?
      render json: { error: 'ユーザーが見つからないか、すでに変更が終わっています' }, status: :not_found
      return
    end

    if user.confirmation_token_expires_at < Time.now
      render json: { error: 'トークンの有効期限が切れています' }, status: :unprocessable_entity
      return
    end

    if user.update(
      password: password,
      confirmation_token: nil,
      confirmation_token_expires_at: nil
    )

    render json: { message: 'パスワードが変更されました。ログインページへ移動します。' }
    else

    render json: { error: user.errors.full_messages }, status: :unprocessable_entity
    end

  end

end
