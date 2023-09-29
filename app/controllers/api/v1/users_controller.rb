class Api::V1::UsersController < ApplicationController
  # userのデータを取得
  def get_user_data
    user_id = params[:user_id]
    user = User.find(user_id)
    render json: user.response_json, status: :ok
  end

end
