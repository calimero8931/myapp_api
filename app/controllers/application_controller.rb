class ApplicationController < ActionController::API
  # Cookieを使う
  include ActionController::Cookies
  # 認可を行う
  include UserAuthenticateService

  # CSRF対策
  before_action :xhr_request?

  private

  def xhr_request?
    # リクエストヘッダ X-Requested-With: 'XMLHttpRequest' の存在を判定
    return if request.xhr?

    # 特定のURLパラメーターが存在する場合、403を返さない
    if specific_parameters_present?
      return
    end

    render status: :forbidden, json: { status: 403, error: "Forbidden", message: "XMLHttpRequestではありません" }
  end

  private

  def specific_parameters_present?
    # メルアド変更メールのクリックで飛んできた人だけ許可
    params[:key] == 'dsyd'

  end

    # def xhr_request?
    #   return if request.xhr?
    #   render status: :forbidden, json: { status: 403, error: "Forbidden",message: "XMLHttpRequestではありません" }
    # end

    # Internal Server Error
    def response_500(msg = "Internal Server Error")
      render status: 500, json: { status: 500, error: msg }
    end
end
