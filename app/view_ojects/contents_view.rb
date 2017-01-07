class ContentsView
  attr_reader :contents, :action_view, :urls, :image_urls, :link_urls

  def initialize(contents)
    @contents = contents
    @action_view = Renderer.new.renderer
    @urls = URI.extract(contents, Constants::URL_SCHEMES)
    set_urls if urls
  end

  def processing_display
    if urls.present?
      link_thumbnail_description if link_urls.present?
      image if image_urls.present?
    end
    convert_br_tag!
    sanitize_content
  end

  private

  def convert_br_tag!
    contents.gsub!(/\R/, '<br>')&.gsub(/<\/div><br>/, '</div>')
  end

  def convert_url_to_html!(url, html)
    html.gsub!(/(?<=>)\s+|\s+(?=<)/, '')
    reg_url = Regexp.escape(url.to_s)
    contents.gsub!(/(#{reg_url}$|#{reg_url}[\W\/])/) { html.to_s }
  end

  def image
    image_urls.uniq.each do |url|
      host_name = URI.parse(url).hostname
      html = action_view.render 'topics/image', url: url, host_name: host_name
      convert_url_to_html!(url, html)
    end
  end

  def link_thumbnail_description
    link_urls.uniq.each do |url|
      site = LinkThumbnailer.generate(url)
      image_url = site.images.present? ?
        site.images.first.src.to_s : 'no_image.png'
      html = action_view.render 'topics/link_thumbnail_description',
                                 site: site,
                                 url: image_url
      convert_url_to_html!(url, html)
    end
  end

  def sanitize_content
    action_view.sanitize(contents,
                          tags: %w(a div img p br),
                          attributes: %w(alt class href src target))
  end

  def set_urls
    @image_urls, @link_urls = urls.partition do |url|
      url.match(/\.(jpg|jpeg|png|gif|bmp)/)
    end
  end
end
