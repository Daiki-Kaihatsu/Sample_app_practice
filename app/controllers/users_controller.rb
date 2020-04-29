class UsersController < ApplicationController
  
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
      flash[:success] = "登録は成功しました"
      #redirect_to user_url(@user)と同じ
      redirect_to @user
    else
      render 'new'
    end
  end
  
  #strong parameter
  #user情報を要求(require)し、以下の入力されたデータを許可(permit)します。
  private
  
    def user_params
      params.require(:user).permit(:name,:email,:password,:password_confirmation)
    end
end
