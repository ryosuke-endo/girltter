require 'nkf'
class User < ActiveRecord::Base
  authenticates_with_sorcery!
  before_save :normalize

  validates :password, length: { minimum: 8 },
                       confirmation: true
  validates :password_confirmation, presence: true
  validates :email, uniqueness: true, email: true
  validates :login, uniqueness: true,
                    format: { with: /\w+/ }

  def normalize
    self.email = NKF::nkf('-wWZ1X', email).downcase
  end
end
