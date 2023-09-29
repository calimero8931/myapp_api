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
end
