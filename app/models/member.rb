class Member < User
  has_many :loves, dependent: :destroy
end
