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

    render json: trophiesData, status: :ok
  end

  def show
    trophy_id = params[:id]
    trophyData = Trophy.find(trophy_id)
    render json: trophyData, status: :ok
  end
end
