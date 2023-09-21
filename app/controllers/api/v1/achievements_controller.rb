class Api::V1::AchievementsController < ApplicationController
  def get_favorite
    user_id = params[:user_id]
    trophy_id = params[:trophy_id]
    favorite = Achievement.find_by(user_id: user_id, trophy_id: trophy_id)

    if favorite.nil?
      already = false
      render json: already , status: :ok
    else
      already = true
      render json: already , status: :ok
    end
  end


  def set_favorite
    user_id = params[:user_id]
    trophy_id = params[:trophy_id]
    favorite = Achievement.find_by(user_id: user_id, trophy_id: trophy_id)

    if favorite.nil?
      favorite = Achievement.new(
        user_id: user_id,
        trophy_id: trophy_id,
        favorite: true,
        success_at: nil,
        image_url: nil,
        created_at: nil,
        updated_at: nil
      )

      if favorite.save
        already = true
        message = "Achievement created successfully."
        render json: { message: message , already: already } , status: :ok
      else
        render json: favorite.errors, status: :unprocessable_entity
      end
    else
      favorite.destroy
      already = false
      message = "Achievement already exists. because destroy it."
      render json: { message: message , already: already } , status: :ok
    end
  end
end
