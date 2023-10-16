class Api::V1::PostsController < ApplicationController
  def create
    uploaded_file = params[:file]
    public_profile_id = params[:user_id]
    public_profile = PublicProfile.find_by(user_id: public_profile_id)

    if public_profile
      # アタッチメントを作成し、ファイルをアタッチ
      attachment = public_profile.profile_image_url.attach(uploaded_file)

      if attachment
        render json: { message: 'ファイルがアップロードされました' }, status: :created
      else
        render json: { error: 'ファイルのアップロードに失敗しました' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'PublicProfileが見つかりません' }, status: :not_found
    end
  end

  def create_trophy
    uploaded_file = params[:file]
    user_id = params[:user_id]
    title = params[:user_name]
    description = params[:bio]
    website = params[:website]
    latitude = params[:latitude]
    longitude = params[:longitude]
    country_id = params[:country_id]
    category_id = params[:category_id]
    sub_category_id = params[:sub_category_id]
    region_id = params[:region_id]
    prefecture_id = params[:prefecture_id]

    trophy = Trophy.new(
      create_user_id: user_id,
      title: title,
      description: description,
      # website: website,
      latitude: latitude,
      longitude: longitude,
      country_id: country_id,
      # category_id: category_id,
      category_id: sub_category_id,
      region_id: region_id,
      prefecture_id: prefecture_id
    )

    if trophy.save
      # アタッチメントを作成し、ファイルをアタッチ
      attachment = trophy.image_url.attach(uploaded_file)

      if attachment
        render json: { message: 'トロフィーが作成されました' }, status: :created
      else
        render json: { error: 'ファイルのアップロードに失敗しました' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Trophyの作成に失敗しました' }, status: :unprocessable_entity
    end
  end

  def index
    render json: Post.all, methods: [:image_url]
  end


  def destroy
    post = Post.find(params[:id])
    post.destroy!
    render json: post
  end

  private

  def post_params
    params.permit(:title, :image)
  end
end