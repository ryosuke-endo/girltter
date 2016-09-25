class Love < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  validates :body, presence: true
  validates :category_id, presence: true
  validates :title, presence: true
end
