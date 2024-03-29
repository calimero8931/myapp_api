class Api::V1::InterestsController < ApplicationController

  def check_interested_sub_categories
    user_id = params[:user_id]
    sub_category_id = params[:sub_category_id]
    interested = Interest.find_by(user_id: user_id, sub_category_id: sub_category_id)

    if interested.nil?
      interested = Interest.new(
        user_id: user_id,
        sub_category_id: sub_category_id
      )

      if interested.save
        render json: { message: 'Interest created successfully' }, status: :ok
      else
        render json: { errors: interested.errors.full_messages }, status: :unprocessable_entity
      end
    else
      interested.destroy
      render json: { message: 'Interest removed successfully' }, status: :ok
    end
  end

  def get_interested_sub_categories
    user_id = params[:user_id]
    trophy_id = params[:trophy_id]
    trophy = Trophy.find(trophy_id)
    sub_category_id = trophy.category_id
    interest = Interest.find_by(user_id: user_id, sub_category_id: sub_category_id)

    if interest.nil?
      already = false
      render json: already, status: :ok
    else
      already = true
      render json: already, status: :ok
    end
  end


end
