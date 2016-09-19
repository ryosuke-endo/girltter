class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :password, length: { minimum: 8 },
                       confirmation: true
  validates :password_confirmation, presence: true
  validates :email, uniqueness: true
  validates :login, uniqueness: true,
                    format: { with: /\w+/ }
end
