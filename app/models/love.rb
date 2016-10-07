class Love < ActiveRecord::Base
  acts_as_taggable
  belongs_to :member
  belongs_to :category
  has_many :supplementals, as: :supplementable, dependent: :destroy

  before_validation :set_tags
  validates :body, presence: true
  validates :category_id, presence: true
  validates :title, presence: true

  class << self
    def update_tags!
      tags = ActsAsTaggableOn::Tag.pluck(:name)
      ActiveRecord::Base.transaction do
        Love.find_each do |love|
          tags.each do |tag|
            if !!(love.body.match(tag))
              love.tag_list << tag
            end
          end
          if love.tag_list.present?
            love.save!
          end
        end
      end
    end
  end

  private

  def set_tags
    tags = ActsAsTaggableOn::Tag.pluck(:name)
    tags.each do |tag|
      if !!(body.match(tag))
        tag_list << tag
      end
    end
  end
end
