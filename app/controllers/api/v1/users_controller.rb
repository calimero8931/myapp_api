class Api::V1::UsersController < ApplicationController
  # userのデータを取得
  def get_user_data
    user_id = params[:params][:user_id]
    user = User
          .find_by(id: user_id)
          .as_json(except: [:activated, :admin,:confirmation_token, :confirmation_token_expires_at, :refresh_jti,:unconfirmed_email, :password_digest, :created_at, :updated_at])
    render json: user, status: :ok
  end

  # アカウント非アクティブ化
  def delete_account
    password = params[:params][:password]
    user_id = params[:params][:user_id]
    user = User.find(user_id)

    if current_user.authenticate(password)
      current_user.update(activated: false)
      render json: { message: "アカウントを非アクティブ化しました" }, status: :ok
    else
      render json: { message: "パスワードが違います" }, status: :unprocessable_entity
    end
  end

  # 管理者権限の確認
  def check_admin
    user = User.find(params[:params][:user_id])
    if user.admin
      render json: { message: "管理者です", admin: true }, status: :ok
    else
      render json: { message: "管理者ではありません" }, status: :unprocessable_entity
    end
  end
end
