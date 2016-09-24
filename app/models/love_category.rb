class LoveCategory < Category
  has_many :loves, foreign_key: :category_id
end
