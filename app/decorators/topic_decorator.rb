# coding: utf-8
module TopicDecorator
  URL_SCHEMES = %w(http https)

  def process_body
    urls = URI.extract(body, URL_SCHEMES)
    if urls.present?
      image_urls, link_urls = urls.partition { |url| url.match(/.*\.([^.]+$)/) }
      image(image_urls) if image_urls.present?
      link_thumbnail_description(link_urls) if link_urls.present?
    end
    body
  end

  private

  def image(urls)
    urls.each do |url|
      host_name = URI.parse(url).hostname
      text = render 'topics/image', url: url, host_name: host_name
      body.gsub!(url, text)
    end
    body
  end

  def link_thumbnail_description(urls)
    urls.each do |url|
      site = LinkThumbnailer.generate(url)
      image_url = site.images.present? ?
        site.images.first.src.to_s : 'no_image.png'
      text = render 'topics/link_thumbnail_description', site: site,
                                                         url: image_url
      body.gsub!(url, text)
    end
    body
  end
end
