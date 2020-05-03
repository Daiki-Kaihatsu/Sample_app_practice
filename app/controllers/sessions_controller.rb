class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      #ログインメソッドを経由してsessionを保持する。
      log_in user
      #ユーザがログイン後にユーザ情報のページにリダイレクトする
     redirect_back_or user
    else
      #エラーメッセージを作成する
      flash.now[:danger] = 'Invalid email/password combination'
    render 'new'
    end
  end
  
  def destroy
    log_out
    redirect_to root_url
  end
end
