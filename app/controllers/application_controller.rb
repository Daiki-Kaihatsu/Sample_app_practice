class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #一時セッションで読み込ませるために設定する。
  include SessionsHelper
end
