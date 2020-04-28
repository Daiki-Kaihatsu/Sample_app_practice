class User < ApplicationRecord
  before_save{ self.email = email.downcase}
  validates :name, presence: true, length: {maximum:50}
  #パターンに一致するメールアドレスだけが有効
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum:255},
                    format:{with:VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}
  has_secure_password
  #パスワードに関するテスト
  validates :password,presence: true,length: {minimum: 6}
end
