class TopicsView

  def self.process_image(body, urls)
    urls.each do |url|
      image_tag = ActionController::Base.helpers.image_tag(url)
      host_name = URI.parse(url).hostname
      text = <<~"EOS"
        <div class="c-grid__quotation-image">
          #{image_tag}
          <a href=#{url} target="_blank">
            出典：#{host_name}
          </a>
        </div>
      EOS
      body.gsub!(url, text)
    end
    body
  end

  def self.process_link(body, urls)
    urls.each do |url|
      site = LinkThumbnailer.generate(url)
      title = site.title
      description = site.description
      image_url =
        if site.images.present?
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
    body
  end
end
