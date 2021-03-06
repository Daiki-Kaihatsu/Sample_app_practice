require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup 
    @user = User.new(name:"Example User",email:"user@example.com",
                     password:"foobar",password_confirmation:"foobar")
  end
  
  test "should be valid"do
    assert @user.valid?
  end
  
  test "name should be present" do
    @user.name = "   "
    assert_not @user.valid?
  end
  
  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?
  end
  
  #名前に５１文字を代入する
  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end
   #メールアドレスに256文字を代入する
  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
  
  #フォーマットの検証、有効なメールアドレス
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US_ER@foo.bar.org
    first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  #フォーマットの検証、有効なメールアドレス
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
     foo@var_baz.com foo@bar+baz.com]
     invalid_addresses.each do |invalid_address|
       @user.email = invalid_address
       assert_not @user.valid?,"#{invalid_address.inspect} should be invalid"
     end
  end
  
  #一意性のテストを行う
  #dupメソッド・・・同じ属性を持つデータを複製するためのメソッド
  test "email addresses should be unique"do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  #空白のチェック
  test "password should be present (nonblank)"do
    @user.password = @user.password_confirmation = "" * 6
    assert_not @user.valid?
  end
  
  #パスワードの最小文字数をテスト（６文字以上）
  test "password should have a minimum length"do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
  
end
