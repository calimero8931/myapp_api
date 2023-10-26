class Api::V1::AuthController < ApplicationController
  def signup
    # ユーザー登録
    user_params = params.require(:user).permit(:name, :email, :password)

    if User.find_by(email: user_params[:email])
      render json: { error: '既に登録されているメールアドレスです' }, status: :unprocessable_entity
      return
    end

    user = User.new(user_params)
    user.activated = false

    confirmation_token = SecureRandom.urlsafe_base64
    confirmation_token_expires_at = 15.seconds.from_now # 5分後
    user.update(
      confirmation_token: confirmation_token,
      confirmation_token_expires_at: confirmation_token_expires_at
      )
    url = api_v1_confirm_signup_url(token: confirmation_token)

    UserMailer.signup_confirmation(user_params[:name], user_params[:email], confirmation_token, url).deliver_now

    if user.save
      render json: { message: 'メールが送信されました' }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def confirm_signup_step1
    token = params[:token]
    redirect_to "http://localhost:8080/login?token=#{token}"
  end

  def confirm_signup_step2
    token = params[:params][:token]

    user = User.find_by(confirmation_token: token)

    if user.nil?
      render json: { error: nil , message: 'ユーザーが見つかりません' }, status: :unprocessable_entity
      return
    end

    # トークンの有効期限をチェック
    if user.confirmation_token_expired?
      user.destroy
      render json: { error: nil , message: 'トークンの有効期限が切れています' }, status: :unprocessable_entity
      return
    end

    if user.confirmation_token == token
      user.update( activated: true , confirmation_token: nil, confirmation_token_expires_at: nil)
      render json: { message: '新規ユーザー登録が完了しました' }
    else
      user.destroy
      render json: { error: nil ,message: '無効なトークンです。もう一度やり直してください。' }, status: :unprocessable_entity
    end
  end

end
