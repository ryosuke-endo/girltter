class Member < User
  has_many :loves, dependent: :destroy
  has_many :comments, dependent: :destroy
end
