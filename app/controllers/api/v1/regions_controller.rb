class Api::V1::RegionsController < ApplicationController
  def index
    regions = Region.order(:id)
    render json: regions.to_json, status: :ok
  end

  def show
    # params から送られてきた数値を取得
    country_id = params[:country_id]  # ここで :country_id は送られてくるパラメータ名に合わせてください
    # regions テーブルから country_id が一致するレコードを取得
    matching_regions = Region.where(country_id: country_id)
    # JSON 形式でデータを返す
    render json: matching_regions
  end
end
