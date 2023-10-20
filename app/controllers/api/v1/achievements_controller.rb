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
        message = "お気に入りに追加しました"
        render json: { message: message , already: already } , status: :ok
      else
        render json: favorite.errors, status: :unprocessable_entity
      end
    else
      favorite.destroy
      already = false
      message = "お気に入りから削除しました"
      render json: { message: message , already: already } , status: :ok
    end
  end

  def get_favorite_list
    user_id = params[:user_id]
    user_achievements = Achievement
      .joins(:trophy)
      .where(user_id: user_id, achievement: false)
      .select('achievements.*, trophies.title as trophy_title')
      .order(:id)

      render json: user_achievements.as_json(except: :image_url)
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

  def compute_achievement_rate
    trophy_id = params[:trophy_id]

    # Trophyを取得
    trophy = Trophy.find_by(id: trophy_id)

    # Trophyが存在しない場合のエラーハンドリング
    if trophy.nil?
      render json: { error: "指定されたトロフィーが見つかりません" }, status: :not_found
      return
    end

    # 興味を持っている人数
    interested_users_count = Interest.where(sub_category_id: trophy.category_id ).count

    # トロフィーを取得した人数（achievementがtrueの場合）
    earned_users_count = Achievement.where(trophy_id: trophy_id, achievement: true).count

    # 取得率を計算
    completion_rate = (earned_users_count.to_f / interested_users_count.to_f * 100).round(2)

    render json: {
      interested_users_count: interested_users_count,
      earned_users_count: earned_users_count,
      completion_rate: completion_rate } , status: :ok
  end

  def get_achievements_image
    user_id = params[:user_id]
    achievements = Achievement.where(user_id: user_id, achievement: true)

    achievements_with_urls = achievements.map do |achievement|
      attachment = achievement.image_url
      if achievement.image_url.attached?
        achievement.attributes.merge(image_url: url_for(attachment))
      else
        achievement.attributes.merge(image_url: url_for('https://www.shoshinsha-design.com/wp-content/uploads/2020/05/noimage-1-760x460.png'))
      end
    end

    render json: achievements_with_urls, status: :ok

  end

  def test
    return "testっす", status: :ok
  end

end
