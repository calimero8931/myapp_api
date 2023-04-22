Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # users_controller.rbのindexアクションを呼び出す
      resources :users, only:[:index]
    end
  end
end
