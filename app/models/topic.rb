class Topic < ActiveRecord::Base
  URL_SCHEMES = %w(http https)

  has_attached_file :thumbnail, styles: { medium: '300x300>', thumb: '140x140>' }
  belongs_to :category

  validate :invalid_extension, if: :exist_url?
  validates :title, presence: true
  validates :body, presence: true
  validates :name, presence: true
  validates_attachment :thumbnail,
                       content_type: { content_type: ['image/jpg',
                                                      'image/jpeg',
                                                      'image/png',
                                                      'image/gif'] }

  def temp_file
    if @temp_file_id.present?
      TempFile.find(@temp_file_id)
    end
  end

  def temp_file=(temp_file)
    file = TempFile.new
    file.temp = temp_file
    file.save
    @temp_file_id = file.id
  end

  def temp_file_id
    @temp_file_id
  end

  private

  def exist_url?
    URI.extract(body, URL_SCHEMES).present?
  end

  def invalid_extension
    urls = URI.extract(body, URL_SCHEMES)
    if urls.map { |x| !!(x.match(/\.(jpg|jpeg|png|gif|bmp)/)) }.include?(false)
      errors.add(:body, "拡張子が不正です")
    end
  end
end
