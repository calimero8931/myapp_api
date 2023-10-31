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

  def upload_achievement_image
    uploaded_file = params[:file]
    achievement_id = params[:achievement_id]
    achievements = Achievement.find_by(id: achievement_id)

    if achievements
      # アタッチメントを作成し、ファイルをアタッチ
      attachment = achievements.image_url.attach(uploaded_file)

      if attachment
        render json: { message: '画像がアップロードされました' }, status: :created
      else
        render json: { error: '画像のアップロードに失敗しました' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'アタッチメントが見つかりません' }, status: :not_found
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
