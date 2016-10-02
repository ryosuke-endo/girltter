class Love < ActiveRecord::Base
  acts_as_taggable
  belongs_to :member
  belongs_to :category
  has_many :supplementals, as: :supplementable, dependent: :destroy

  validates :body, presence: true
  validates :category_id, presence: true
  validates :title, presence: true
end
