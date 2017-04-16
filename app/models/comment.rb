class Comment < ActiveRecord::Base
  has_attached_file :image,
    styles: { normal: '500x500>',
              thumbnail: '140x140>' }

  belongs_to :topic
  has_many :reactions, as: :reactionable
  has_many :icons, through: :reactions

  before_create :process_body
  after_create :topic_update_time

  validates :body, presence: true
  validates :name, presence: true
  validates_attachment :image,
    content_type: { content_type: ['image/jpg',
                                   'image/jpeg',
                                   'image/png',
                                   'image/gif',
                                   'image/bmp'] },
    less_than: 20.megabytes

  private

  def process_body
    options = { nofollow: true }
    self.body = ContentsView.new(body).processing_display(options)
  end

  def topic_update_time
    topic.updated_at = updated_at
    topic.save
  end
end
