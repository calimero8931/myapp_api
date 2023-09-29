class Api::V1::PublicProfilesController < ApplicationController
  def show
    user_id = params[:id]
    user = User.find(user_id)
    render json: user, status: :ok
  end

  def create
    user_id = params[:params][:user_id]
    user_name = params[:params][:user_name]
    profile_image_url = params[:params][:profile_image_url]
    bio = params[:params][:bio]
    website = params[:params][:website]
    public_profile = PublicProfile.find_by(user_id: user_id)

    if public_profile.nil?
      public_profile = PublicProfile.new(
        user_id: user_id,
        username: user_name,
        profile__image_url: profile_image_url,
        bio: bio,
        website: website
      )
      else
        public_profile.update(
        username: user_name,
        profile__image_url: profile_image_url,
        bio: bio,
        website: website
        )
    end

    if public_profile.save
      render json: { public_profile: public_profile, message: "保存されました" } , status: :ok
    else
      render json: {public_profile: public_profile.errors, message: "保存に失敗しました" }, status: :unprocessable_entity
    end
  end



  def get_favorite
    user_id = params[:user_id]
    trophy_id = params[:trophy_id]
    favorite = Achievement.find_by(user_id: user_id, trophy_id: trophy_id)

    if favorite.nil?
      already = false
      render json: already , status: :ok
    else
      already = true
      render json: already , status: :ok
    end
  end
end
