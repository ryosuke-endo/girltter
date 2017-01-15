class Topic < ActiveRecord::Base
  has_attached_file :thumbnail,
    styles: { normal: '500x500>',
              thumbnail: '140x140>' }

  has_many :comments, dependent: :destroy

  belongs_to :category

  before_create :set_topic_view

  validates :title, presence: true
  validates :body, presence: true
  validates :name, presence: true
  validates_attachment :thumbnail,
    content_type: { content_type: ['image/jpg',
                                   'image/jpeg',
                                   'image/png',
                                   'image/gif',
                                   'image/bmp'] },
    less_than: 20.megabytes

  def thumbnails_first
    thumbnails_urls.first
  end

  private

  def thumbnails_urls
    URI.extract(body, Constants::URL_SCHEMES).select do |url|
      url.match(/\.(jpg|jpeg|png|gif|bmp)$/)
    end
  end

  def set_topic_view
    self.body = ContentsView.new(body).processing_display
  end
end
