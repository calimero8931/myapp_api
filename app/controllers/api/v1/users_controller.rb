class Api::V1::UsersController < ApplicationController
  # userのデータを取得
  def get_user_data
    user_id = params[:user_id]
    user = User.find(user_id)
    render json: user.response_json, status: :ok
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
