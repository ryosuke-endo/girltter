require 'nkf'
class User < ActiveRecord::Base
  ALPHANUMERIC_REG = /\A[a-z\d\_\-]+\z/i
  authenticates_with_sorcery!
  before_save :normalize_value

  validates :password, confirmation: true,
                       format: { with: ALPHANUMERIC_REG , message: 'は半角英数字で入力してください'},
                       length: { minimum: 8, maximum: 20 },
                       presence: true
  validates :password_confirmation, presence: true
  validates :email, uniqueness: true,
                    email: { message: 'の入力が正しくありません' },
                    presence: true
  validates :login, uniqueness: true,
                    format: { with: ALPHANUMERIC_REG , message: 'は半角英数字で入力してください'},
                    length: { minimum: 3, maximum: 20 },
                    presence: true

  def normalize_value
    self.email = NKF::nkf('-wWZ1X', email).downcase
  end
end
