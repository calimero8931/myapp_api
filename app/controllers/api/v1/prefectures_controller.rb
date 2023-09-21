class Api::V1::PrefecturesController < ApplicationController
  def index
    prefectures = Prefecture.order(:id)
    render json: prefectures.to_json, status: :ok
  end

  def show
    region_id = params[:region_id]
    matching_prefectures = Prefecture.where(region_id: region_id)
    render json: matching_prefectures, status: :ok
  end
end
