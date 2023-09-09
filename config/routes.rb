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

    end
  end
end
