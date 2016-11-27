class Love < ActiveRecord::Base
  acts_as_taggable
  belongs_to :member
  belongs_to :category

  has_many :supplementals, as: :supplementable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :reads, as: :readable, dependent: :destroy

  before_validation :set_tags

  validates :body, presence: true
  validates :category_id, presence: true
  validates :title, presence: true
  validates :read_count, presence: true,
                         numericality: { only_integer: true }

  def daily_counter
    name = self.class.name.tableize
    RedisService.count_up(id, name)
  end

  def update_read_count(date)
    name = self.class.name.tableize
    total_count = RedisService.count(id, name, date) + read_count
    update(read_count: total_count)
    RedisService.zrem(id, name, date)
  end

  def self.update_tags!
    ActiveRecord::Base.transaction do
      Love.find_each do |love|
        new.all_tags.each do |tag|
          if !!(love.body.match(tag))
            love.tag_list << tag
          end
        end
        love.save! if love.tag_list.present?
      end
    end
  end

  def all_tags
    ActsAsTaggableOn::Tag.pluck(:name)
  end

  private

  def set_tags
    all_tags.each do |tag|
      if !!(body.match(tag))
        tag_list << tag
      end
    end
  end
end
