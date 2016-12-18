# coding: utf-8
module TopicDecorator
  def process_body
    urls = URI.extract(body, Constants::URL_SCHEMES)
    body.gsub!(/\r\n|\r|\n/, '<br />')
    if urls.present?
      image_urls, link_urls = urls.partition { |url| url.match(/\.(jpg|jpeg|png|gif|bmp)/) }
      image(image_urls) if image_urls.present?
      link_thumbnail_description(link_urls) if link_urls.present?
      body.gsub!(/>br \/>/, '>')
    end
    sanitize(body, tags: %w(a br div img p), attributes: %w(alt class href src target))
  end

  private

  def image(urls)
    urls.uniq.each do |url|
      host_name = URI.parse(url).hostname
      html = render 'topics/image', url: url, host_name: host_name
      convert_url_to_html!(url, html)
    end
  end

  def link_thumbnail_description(urls)
    urls.uniq.each do |url|
      site = LinkThumbnailer.generate(url)
      image_url = site.images.present? ?
        site.images.first.src.to_s : 'no_image.png'
      html = render 'topics/link_thumbnail_description', site: site,
                                                         url: image_url
      convert_url_to_html!(url, html)
    end
  end

  def convert_url_to_html!(url, html)
    reg_url = Regexp.escape("#{url}")
    body.gsub!(/(#{reg_url}$|#{reg_url}[\W\/])/){ |s| "#{html}"}
  end
end
