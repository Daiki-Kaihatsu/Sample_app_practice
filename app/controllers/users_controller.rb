class UsersController < ApplicationController
  #editとupdateが実行される前にログイン済ユーザーなのか確認する。
  before_action :logged_in_user,only:[:index,:edit,:update,:destroy]
  before_action :correct_user,only:[:edit,:update]
  before_action :admin_user, only: :destroy
  
  #ページネーションを実行するためアクションでUsersをページネートする
  def index
    @users = User.paginate(page:params[:page])
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    #new.html.erbからpostでデータを受け取り、エラーがないかチェックする。エラーがあればエラーを表示させる
    #登録が成功したら成功のメッセージを描画する
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "登録は成功しました"
      #redirect_to user_url(@user)と同じ
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "登録は成功しました"
      #redirect_to user_url(@user)と同じ
      redirect_to @user
    else
      render 'edit'
    end
  end
  
 def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
 end
  
  
  #strong parameter
  #user情報を要求(require)し、以下の入力されたデータを許可(permit)します。
  private
  
    def user_params
      params.require(:user).permit(:name,:email,:password,:password_confirmation)
    end
    
  #ログイン済ユーザーか確認
  def logged_in_user
    #もしログインしていなければ...session_helper.rb　論理値を返す。
    unless logged_in?
      #ログインしようとしたURLを保存
      store_location
      flash[:danger] = "ログインしてください"
      redirect_to login_url
    end
  end
  
  #正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end
  
  #削除するときに管理者かどうか確認する
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
