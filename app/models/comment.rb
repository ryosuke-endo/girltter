class Comment < ActiveRecord::Base
  has_attached_file :image,
    styles: { normal: '500x500>',
              thumbnail: '140x140>' }

  belongs_to :topic
  has_many :comment_reaction_icons
  has_many :reaction_icons, through: :comment_reaction_icons

  before_create :process_body

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
    self.body = ContentsView.new(body).processing_display
  end
end
