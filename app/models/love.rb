class Love < ActiveRecord::Base
  acts_as_taggable
  belongs_to :member
  belongs_to :category
  has_many :supplementals, as: :supplementable, dependent: :destroy

  before_validation :set_tags
  validates :body, presence: true
  validates :category_id, presence: true
  validates :title, presence: true

  def set_tags
    tags = ActsAsTaggableOn::Tag.pluck(:name)
    tags.each do |tag|
      if !!(body.match(tag))
        tag_list << tag
      end
    end
  end
end
