class Api::V1::SubCategoriesController < ApplicationController

  def index
    sub_categories = SubCategory.all.order(:id)
    render json: sub_categories, status: :ok
  end

  # def selected_sub_categories
  #   category_id = params[:user_id]
  #   sub_categories = SubCategory.where(category_id: category_id).order(:category_id)
  #   render json: sub_categories, status: :ok
  # end

  # def non_selected_sub_categories
  #   category_id = params[:user_id]
  #   sub_categories = SubCategory.where(category_id: category_id).order(:category_id)
  #   render json: sub_categories, status: :ok
  # end

  def interested_sub_categories

    sub_categories = SubCategory
    # .joins(:interests)
    .joins("LEFT JOIN interests ON interests.sub_category_id = sub_categories.id")
    .select('sub_categories.*, COALESCE(interests.user_id, NULL) as interested_sub_category_id')
    .order(:id)

    render json: sub_categories, status: :ok
  end

  def show
    # paramsのcategory_idを取得
    category_id = params[:category_id]
    sub_categories = SubCategory.where(category_id: category_id).order(:category_id)
    render json: sub_categories, status: :ok
  end
end
