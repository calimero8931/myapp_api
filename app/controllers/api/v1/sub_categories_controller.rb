class Api::V1::SubCategoriesController < ApplicationController
  def index
    # paramsのcategory_idを取得
    category_id = params[:category_id]
    sub_categories = SubCategory.where(category_id: category_id).order(:category_id)
    render json: sub_categories, status: :ok
  end
end
