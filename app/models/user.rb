require 'nkf'
class User < ActiveRecord::Base
  authenticates_with_sorcery!
  before_save :normalize_value

  validates :password, length: { minimum: 8 },
                       confirmation: true,
                       presence: true
  validates :password_confirmation, presence: true
  validates :email, uniqueness: true,
                    email: { message: 'は半角英数字で入力してください' },
                    presence: true
  validates :login, uniqueness: true,
                    format: { with: /\A[a-z\d\_\-]+\z/i , message: 'は半角英数字で入力してください'},
                    length: { minimum: 4, maximum: 20 },
                    presence: true

  def normalize_value
    self.email = NKF::nkf('-wWZ1X', email).downcase
  end
end
