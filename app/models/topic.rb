class Topic < ActiveRecord::Base
  URL_SCHEMES = %w(http https)

  has_attached_file :thumbnail, styles: { medium: '300x300>', thumb: '140x140>' }
  belongs_to :category
  before_validation :extract_url

  validates :title, presence: true
  validates :body, presence: true
  validates :name, presence: true
  validates_attachment :thumbnail,
                       content_type: { content_type: ['image/jpg',
                                                      'image/jpeg',
                                                      'image/png',
                                                      'image/gif'] }

  def extract_url
    urls = URI.extract(body, URL_SCHEMES)
    return unless urls.present?
    image_urls, site_urls = urls.partition { |url| url.match(/\.(jpg|jpeg|png|gif)/) }
    site_urls.each do |url|
      site = LinkThumbnailer.generate(url)
      title = site.title
      description = site.description
      image_url =
        if site.images.first.src.to_s
          site.images.first.src.to_s
        else
          'no_image.png'
        end
      image_tag = ActionController::Base.helpers.image_tag(image_url)
      text = <<~"EOS"
      <a href=#{url} target="_blank" class="c-grid__quotation--link">
        <div class="c-grid__quotation text--s-md p-topic__quotation__border c-border-r-5">
          <div class="c-flex">
            <div class="c-grid__quotation--main">
              #{image_tag}
            </div>
            <div class="c-grid__quotation--side">
              <div class="c-grid__quotation--side-title text--b">
                #{title}
              </div>
              <div class="c-grid__quotation--side-description">
                #{description}
              </div>
              <div class="c-grid__quotation--side-url">
                #{site.url.host}
              </div>
            </div>
          </div>
        </div>
      </a>
      EOS
      body.gsub!(url, text)
    end
    image_urls.each do |image_url|
      image_tag = ActionController::Base.helpers.image_tag(image_url)
      host_name = URI.parse(image_url).hostname
      text = <<~"EOS"
        <div class="c-grid__quotation-image">
          #{image_tag}
          <a href=#{image_url} target="_blank">
            出典：#{host_name}
          </a>
        </div>
      EOS
      body.gsub!(image_url, text)
    end
  end

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
end
