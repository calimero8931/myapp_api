class ApplicationController < ActionController::API
  # Cookieを使う
  include ActionController::Cookies
  # 認可を行う
  include UserAuthenticateService
end
