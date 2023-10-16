class Api::V1::TrophiesController < ApplicationController
  def index
    category_id = params[:category_id]
    trophies = Trophy.where(category_id: category_id).order(:id)
    render json: trophies.to_json, status: :ok
  end

  def list
    sub_categories_id = params[:param1]
    prefecture_id = params[:param2]
    trophiesData = Trophy.where( category_id:sub_categories_id ,prefecture_id: prefecture_id).order(:id)

    render json: trophiesData.as_json(except: :image_url), status: :ok
  end

  def show
    trophy_id = params[:id]
    trophyData = Trophy.find(trophy_id)
    attachment = trophyData.image_url
    if trophyData.image_url.attached?
      trophyData = trophyData.attributes.merge(image_url: url_for(attachment))
    else
      trophyData = trophyData.attributes.merge(image_url: url_for('https://www.shoshinsha-design.com/wp-content/uploads/2020/05/noimage-1-760x460.png'))
    end

    render json: trophyData, status: :ok
  end

  def recommend
    user_id = params[:user_id]
    trophies = Trophy.where(category_id: 1).order('RANDOM()').limit(10)

    trophies_with_urls = trophies.map do |trophy|
      attachment = trophy.image_url
      if trophy.image_url.attached?
        trophy.attributes.merge(image_url: url_for(attachment))
      else
        trophy.attributes.merge(image_url: url_for('https://www.shoshinsha-design.com/wp-content/uploads/2020/05/noimage-1-760x460.png'))
      end
    end

    render json: trophies_with_urls, status: :ok
  end

end
