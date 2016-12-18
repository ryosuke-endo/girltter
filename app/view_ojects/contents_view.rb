class ContentsView
  attr_reader :contents, :view_context, :urls, :image_urls, :link_urls

  def initialize(contents, view_context)
    @contents = contents
    @view_context = view_context
    @urls = URI.extract(contents, Constants::URL_SCHEMES)
    set_urls if urls
  end

  def processing_display
    if urls.present?
      link_thumbnail_description if link_urls.present?
      image if image_urls.present?
      return view_context.simple_format(sanitize_content)
    end
    view_context.simple_format(contents)
  end

  private

  def sanitize_content
    view_context.sanitize(contents,
                          tags: %w(a div img p),
                          attributes: %w(alt class href src target))
  end

  def set_urls
    @image_urls, @link_urls = urls.partition do |url|
      url.match(/\.(jpg|jpeg|png|gif|bmp)/)
    end
  end

  def image
    image_urls.uniq.each do |url|
      host_name = URI.parse(url).hostname
      html = view_context.render 'topics/image', url: url, host_name: host_name
      convert_url_to_html!(url, html)
    end
  end

  def link_thumbnail_description
    link_urls.uniq.each do |url|
      site = LinkThumbnailer.generate(url)
      image_url = site.images.present? ?
        site.images.first.src.to_s : 'no_image.png'
      html = view_context.render 'topics/link_thumbnail_description',
                                 site: site,
                                 url: image_url
      convert_url_to_html!(url, html)
    end
  end

  def convert_url_to_html!(url, html)
    reg_url = Regexp.escape(url.to_s)
    contents.gsub!(/(#{reg_url}$|#{reg_url}[\W\/])/) { html.to_s }
  end
end
