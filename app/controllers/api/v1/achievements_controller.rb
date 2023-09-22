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

  def get_achievements
    user_id = params[:user_id]
    # achievements = Achievement.where(user_id: user_id).order(:id)
    user_achievements = Achievement
      .joins(:trophy)
      .where(user_id: user_id)
      .select('achievements.*, trophies.title as trophy_title, trophies.description as trophy_description').order(:id)

    render json: user_achievements, status: :ok
  end

  def achieve_trophy
    user_id = params[:user_id]
    trophy_id = params[:trophy_id]
    achievement = Achievement.find_by(user_id: user_id, trophy_id: trophy_id)
    if Achievement
      # レコードが見つかった場合、見つかったレコードのachievementカラムをtrueに設定して保存
      Achievement.update(achievement.id, achievement: true , success_at: Time.now)
      render json: { message: 'トロフィーを獲得しました' }
    else
      # レコードが見つからなかった場合、エラーメッセージを返すなどの処理を行う
      render json: { error: '該当するレコードが見つかりませんでした' }, status: :not_found
    end
  end
end
