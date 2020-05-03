require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user       = users(:michael)
    @other_user = users(:archer)
  end
 
  
  test "should get new" do
    get signup_path
    assert_response :success
  end
  
  #beforeフィルターをコメントアウトして巨大なセキュリティーホールが作られたら、テストスイートでそれを検出できるか
  
  test "should redirect edit whn not logged in" do
    #編集画面へ遷移
    get edit_user_path(@user)
    #flashは空白ではないですよね?
    assert_not flash.empty?
    #ログインしていないユーザなのでちゃんとログイン画面に遷移しますよね？
    assert_redirected_to login_url
  end
  
  test "should redirect update when not logged in" do
    patch user_path(@user), params:{user:{name: @user.name,
                                    email: @user.email}}
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect edit when logged in as wrong user" do
    #２人目のユーザーがログインして１人目のユーザーの編集情報を変更しようとしたとき
    #２人目のユーザでログイン
    log_in_as(@other_user)
    #１人目の編集画面に遷移する
    get edit_user_path(@user)
    #flashは空白ですよね？
    assert flash.empty?
    #ルート画面に遷移する
    assert_redirected_to root_url
  end
  
  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  #ユーザ一覧ページのテスト
  test "should redirect index when not logged in" do
    #ログインしないで一覧ページにアクセスしようとしたらログインページに遷移する
    get users_path
    assert_redirected_to login_url
  end
  
    test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end

end
