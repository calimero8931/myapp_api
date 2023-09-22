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

      # friend申請
      post '/friend_request/', to: 'friendships#friend_request'
      # post '/friend_request/', to: proc { [200, {}, ['とりあえず返します']] }

      # category取得
      get '/categories_request/', to: 'categories#index'

      # sub_categories取得
      get '/sub_categories_request/', to: 'sub_categories#index'

      # countries取得

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

    end
  end
end
