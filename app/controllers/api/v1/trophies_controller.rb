class Api::V1::TrophiesController < ApplicationController
  def index
    category_id = params[:category_id]
    trophies = Trophy.where(category_id: category_id).order(:id)
    render json: trophies.to_json, status: :ok
  end

  def show
    trophy = Trophy.find(params[:id])

    render json: trophy.to_json, status: :ok
  end
end
