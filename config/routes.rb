Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # auth_token
      resources :auth_token, only:[:create] do
        post :refresh,on: :collection
        delete :destroy,on: :collection
      end

      #新規登録の確認メール
      get '/confirm_signup/:token', to: 'auth#confirm_signup_step1', as: 'confirm_signup'

      #新規登録のリダイレクト後の処理
      post '/confirm_signup2/', to: 'auth#confirm_signup_step2'

      # password_resetのメール
      post '/password_reset_step1/', to: 'user_password#password_reset_step1'

      get '/password_reset_step2/:token', to: 'user_password#password_reset_step2', as: 'password_reset'

      post '/password_reset_step3/', to: 'user_password#password_reset_step3'

      # checkAdmin
      post '/check_admin/', to: 'users#check_admin'

      # projects
      resources :projects, only:[:index]

      post '/signup', to: 'auth#signup'

      # nameとemail取得
      post '/get_user_data/', to: 'users#get_user_data'

      # recommend取得
      get '/recommend_request/', to: 'trophies#recommend'

      # 画像アップロード
      post '/uploads/', to: 'posts#create'

      post '/upload_achievement_image/', to: 'posts#upload_achievement_image'

      get '/get_achievements_image/:user_id', to: 'achievements#get_achievements_image'

      get '/get_profile_img/:id', to: 'public_profiles#get_profile_img'

      post '/trophy/uploads/', to: 'trophies#create_trophy'

      # お問い合わせ送信
      post '/contacts/', to: 'user_email#send_contact_confirmation'

      # メールアドレス変更
      post '/change_email/', to: 'user_email#request_change'

      # メールアドレス変更確認1
      get '/confirm_email/:id/:token', to: 'user_email#confirm_email_change_step1', as: 'confirm_email_change'

      # メールアドレス変更確認2
      get '/confirm_email2/', to: 'user_email#confirm_email_change_step2'

      # パスワード変更
      post '/change_password/', to: 'user_password#request_change'

      # アカウント非アクティブ化
      post '/delete_account/', to: 'users#delete_account'

      # friend申請
      post '/friend_request/', to: 'friendships#friend_request'
      # post '/friend_request/', to: proc { [200, {}, ['とりあえず返します']] }

      # category取得
      get '/categories_request/', to: 'categories#index'

      # sub_categories取得
      get '/sub_categories_request/', to: 'sub_categories#show'

      # non_selected_sub_categories取得
      get '/interested_sub_categories/', to: 'sub_categories#interested_sub_categories'

      # interestedの登録
      get '/check_interested_sub_categories/', to: 'interests#check_interested_sub_categories'

      # regions取得
      get '/regions_request/', to: 'regions#show'

      # prefectures取得
      get '/prefectures_request/', to: 'prefectures#show'

      # trophies取得
      get '/results/', to: 'trophies#list'

      # trophy個別取得
      get 'trophy/', to: 'trophies#show'

      # すでにfavoriteしてる？
      get '/get_favorite/', to: 'achievements#get_favorite'

      # favorite登録
      get '/favorite_request/', to: 'achievements#set_favorite'

      # すでにinterestしてる？
      get '/get_interested/', to: 'interests#get_interested_sub_categories'

      # achievement取得
      get '/get_favorite_list/', to: 'achievements#get_favorite_list'

      # trophy画像取得
      get '/get_trophy_image/', to: 'trophies#get_favorite_trophy_image'

      # achieve_trophy
      get '/achieve_trophy/', to: 'achievements#achieve_trophy'

      # public_profileのセット
      post '/set_public_profile/', to: 'public_profiles#create'

      # public_profileページget_hash
      get '/account/get_hash/:id', to: 'public_profiles#get_hash'

      # public_profileページ
      get '/account/public-profile/:hash', to: 'public_profiles#page_show', as: 'public_profile'

      # public_profileページ
      get '/share/:hash', to: 'public_profiles#page_show'

      # トロフィー取得率計算
      get '/compute_achievement_rate/', to: 'achievements#compute_achievement_rate'

    end
  end
end
