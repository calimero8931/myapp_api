Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # auth_token
      resources :auth_token, only:[:create] do
        post :refresh,on: :collection
        delete :destroy,on: :collection
      end

      # projects
      resources :projects, only:[:index]

      post '/signup', to: 'auth#signup'

      # usersデータ取得
      get '/data/', to: 'users#get_user_data'
      # get '/data/', to: proc { [200, {}, ['とりあえず返します']] }

      # メールアドレス変更
      post '/change_email/', to: 'user_email#request_change'

      # メールアドレス変更確認1
      get '/confirm_email/:id/:token', to: 'user_email#confirm_email_change_step1', as: 'confirm_email_change'

      # メールアドレス変更確認2
      get '/confirm_email2/', to: 'user_email#confirm_email_change_step2'

      # パスワード変更
      post '/change_password/', to: 'user_password#request_change'

      # アカウント非アクティブ
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

      # favorite取得
      get '/get_favorite/', to: 'achievements#get_favorite'

      # favorite登録
      get '/favorite_request/', to: 'achievements#set_favorite'

      # achievement取得
      get '/get_achievements_list/', to: 'achievements#get_achievements'

      # achieve_trophy
      get '/achieve_trophy/', to: 'achievements#achieve_trophy'

      # public_profileのセット
      post '/set_public_profile/', to: 'public_profiles#create'

    end
  end
end
