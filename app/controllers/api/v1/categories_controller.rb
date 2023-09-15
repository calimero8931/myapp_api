class Api::V1::CategoriesController < ApplicationController
  def index
    categories = Category.order(:id)
    render json: categories.to_json, status: :ok
  end
end
