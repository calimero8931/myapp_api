class Api::V1::FriendshipsController < ApplicationController
  def friend_request
    user_params = params.require(:params).permit(:friend_id, :user_id)
    friendship = Friendship.new(user_params)
    if friendship.save
      render json: { message: '友達申請が完了しました' }, status: :created
    else
      render json: { errors: friendship.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
