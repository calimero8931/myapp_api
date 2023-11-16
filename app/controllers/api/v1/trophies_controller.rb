class Api::V1::TrophiesController < ApplicationController
  def index
    category_id = params[:category_id]
    trophies = Trophy.where(category_id: category_id).order(:id)
    render json: trophies.to_json, status: :ok
  end

  def list
    sub_categories_id = params[:param1]
    prefecture_id = params[:param2]
    trophyData = Trophy
                       .joins(:prefecture)
                       .where( category_id:sub_categories_id ,prefecture_id: prefecture_id)
                       .select('trophies.*, prefectures.name as prefecture_name')
                       .order(:id)

    trophies_with_urls = trophyData.map do |trophy|
      attachment = trophy.image_url
      if trophy.image_url.attached?
        trophy.attributes.merge(image_url: url_for(attachment))
      else
        trophy.attributes.merge(image_url: url_for('/noimage.png'))
      end
    end

    render json: trophies_with_urls, status: :ok
  end

  def show
    trophy_id = params[:id]
    trophyData = Trophy.find(trophy_id)
    attachment = trophyData.image_url
    if trophyData.image_url.attached?
      trophyData = trophyData.attributes.merge(image_url: url_for(attachment))
    else
      trophyData = trophyData.attributes.merge(image_url: url_for('/noimage.png'))
    end

    render json: trophyData, status: :ok
  end

  def get_favorite_trophy_image
    user_id = params[:user_id]
    #achievementsテーブルのuser_idカラムからuser_idと合うものを取得しtrophy_idを取得
    achievements = Achievement.where(user_id: user_id, achievement: false)

    trophy_ids = achievements.pluck(:trophy_id)

    # trophiesテーブルから該当するtrophy_idのレコードを取得し、image_urlを取り出す
    favorite_trophies = Trophy.where(id: trophy_ids).select(:id, :image_url)

    trophies_with_urls = favorite_trophies.map do |trophy|
      attachment = trophy.image_url
      if trophy.image_url.attached?
        trophy.attributes.merge(image_url: url_for(attachment))
      else
        trophy.attributes.merge(image_url: url_for('/noimage.png'))
      end
    end

    render json: trophies_with_urls, status: :ok

  end

  def recommend
    user_id = params[:user_id]
    trophies = Trophy.where(category_id: 1)
                     .joins(:prefecture)
                     .order('RANDOM()')
                     .limit(10)
                     .select('trophies.*, prefectures.name as prefecture_name')


    trophies_with_urls = trophies.map do |trophy|
      attachment = trophy.image_url
      if trophy.image_url.attached?
        trophy.attributes.merge(image_url: url_for(attachment))
      else
        trophy.attributes.merge(image_url: url_for('/noimage.png'))
      end
    end

    render json: trophies_with_urls, status: :ok
  end

  def get_new_trophy
    user_id = params[:user_id]
    trophies = Trophy
                .joins(:prefecture)
                .order(created_at: :desc)
                .limit(10)
                .select('trophies.*, prefectures.name as prefecture_name')

    trophies_with_urls = trophies.map do |trophy|
      attachment = trophy.image_url
      if trophy.image_url.attached?
        trophy.attributes.merge(image_url: url_for(attachment))
      else
        trophy.attributes.merge(image_url: url_for('/noimage.png'))
      end
    end

    render json: trophies_with_urls, status: :ok
  end

  def create_trophy
    uploaded_file = params[:file]
    user_id = params[:user_id]
    title = params[:user_name]
    description = params[:bio]
    website = params[:website]
    latitude = params[:latitude]
    longitude = params[:longitude]
    country_id = params[:country_id]
    category_id = params[:category_id]
    sub_category_id = params[:sub_category_id]
    region_id = params[:region_id]
    prefecture_id = params[:prefecture_id]

    new_trophy = Trophy.new(
      create_user_id: user_id,
      title: title,
      description: description,
      latitude: latitude,
      longitude: longitude,
      country_id: country_id,
      category_id: sub_category_id,
      region_id: region_id,
      prefecture_id: prefecture_id
    )


    if new_trophy.save
      attachment = new_trophy.image_url.attach(uploaded_file)

      if attachment
        render json: { message: 'トロフィーが作成されました' }, status: :created
      else
        render json: { error: '画像のアップロードに失敗しました' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Trophyの作成に失敗しました' }, status: :unprocessable_entity
    end
  end

  def get_all_trophy_list
    trophies = Trophy.all
                .order(:id)

    render json: trophies.as_json(except: :image_url), status: :ok
  end

  def delete_trophy
    trophy_id = params[:params][:trophy_id]
    trophy = Trophy.find(trophy_id)

    if trophy.destroy
      render json: { message: 'トロフィーを削除しました' }, status: :ok
    else
      render json: { error: 'トロフィーの削除に失敗しました' }, status: :unprocessable_entity
    end
  end

end
