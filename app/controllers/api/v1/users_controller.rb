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
end
