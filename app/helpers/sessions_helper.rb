module SessionsHelper
  #渡されたユーザーでログインする
  #ユーザーのブラウザ内の一時cookiesに暗号化済みのユーザーIDが自動で作成
  def log_in(user)
    session[:user_id] = user.id
  end
  
  #現在ログイン中のユーザを返す(いる場合)
  #セッションにユーザーIDが存在しない場合、nil
  def current_user
    if session[:user_id]
      @current_user || User.find_by(id:session[:user_id])
    end
  end
  
  #ユーザがログインしていればtrue,その他ならfalse。logged_in?で論理値を返す。つまり、nilではないですよね?
  def logged_in?
    !current_user.nil?
  end
  
  #現在のユーザをログアウトする
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
