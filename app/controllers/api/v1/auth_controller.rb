class Api::V1::AuthController < ApplicationController
  def signup
    # ユーザー登録
    user_params = params.require(:user).permit(:name, :email, :password)
    user = User.new(user_params)
    user.activated = true

    if user.save
      render json: { message: 'ユーザーが正常に登録されました' }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
