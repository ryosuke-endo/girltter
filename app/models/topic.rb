class Topic < ActiveRecord::Base
  include TempFileable

  has_attached_file :thumbnail, styles: { medium: '300x300>', thumbnail: '140x140>' }
  belongs_to :category

  after_create :set_topic_view

  validates :title, presence: true
  validates :body, presence: true
  validates :name, presence: true
  validates_attachment :thumbnail,
                       content_type: { content_type: ['image/jpg',
                                                      'image/jpeg',
                                                      'image/png',
                                                      'image/gif'] }

  private

  def set_topic_view
    self.body = ContentsView.new(body).processing_display
    save
  end
end
