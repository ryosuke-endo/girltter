require 'nkf'
class User < ActiveRecord::Base
  ALPHANUMERIC_REG = /\A[a-z\d\_\-]+\z/i
  authenticates_with_sorcery!

  enum sex: %i(unselected man woman)

  before_save :normalize_value

  validates :password, confirmation: true,
                       format: { with: ALPHANUMERIC_REG,
                                 message: I18n.t('errors.messages.alphanumeric') },
                       length: { minimum: 8, maximum: 20 },
                       presence: true, unless: :create, on: :create
  validates :password_confirmation, presence: true, on: :create
  validates :email, uniqueness: true,
                    email: { message: I18n.t('errors.messages.invalid') },
                    presence: true
  validates :login, uniqueness: true,
                    format: { with: ALPHANUMERIC_REG,
                              message: I18n.t('errors.messages.alphanumeric') },
                    length: { minimum: 3, maximum: 20 },
                    presence: true

  def normalize_value
    self.email = NKF::nkf('-wWZ1X', email).downcase
  end
end
