require 'nkf'
class User < ActiveRecord::Base
  attr_accessor :skip_validate_password
  ALPHANUMERIC_REG = /\A[a-z\d\_\-]+\z/i
  authenticates_with_sorcery!

  enum sex: %i(unselected man woman)

  before_validation :set_name, on: :create
  before_save :normalize_value

  validates :name, presence: true
  validates :email, uniqueness: true,
                    email: { message: I18n.t('errors.messages.invalid') },
                    presence: true
  validates :login, uniqueness: true,
                    format: { with: ALPHANUMERIC_REG,
                              message: I18n.t('errors.messages.alphanumeric') },
                    length: { minimum: 3, maximum: 20 },
                    presence: true

  with_options unless: :skip_validate_password? do
    validates :password, confirmation: true,
                         format: { with: ALPHANUMERIC_REG,
                                   message: I18n.t('errors.messages.alphanumeric') },
                         length: { minimum: 8, maximum: 20 },
                         presence: true
    validates :password_confirmation, presence: true
  end


  def normalize_value
    self.email = NKF::nkf('-wWZ1X', email).downcase
  end

  private

  def set_name
    self.name = login
  end

  def skip_validate_password?
    skip_validate_password == true
  end
end
