class ContentsView
  include ActionView::Helpers::SanitizeHelper
  attr_reader :contents, :renderer, :urls, :image_urls, :link_urls

  def initialize(contents)
    @contents = contents
    @renderer = ApplicationController.renderer
    @urls = URI.extract(contents, Constants::URL_SCHEMES)
    set_urls if urls
  end

  def processing_display(options = {})
    if urls.present?
      link_thumbnail_description(options[:nofollow]) if link_urls.present?
      image if image_urls.present?
    end
    extract_anchor!
    convert_br_tag!
    sanitize_content
  end

  private

  def extract_anchor!
    contents.gsub!(/(\>\>.*\d)/) { "<span id='p-anchor-res' data-anchor=true>#{$1}</span>" }
  end

  def convert_br_tag!
    contents.gsub!(%r{(?<!</a>|</div>|-->)\R}, '<br>')
  end

  def convert_url_to_html!(url, html)
    html.gsub!(/(?<=>)\s+|\s+(?=<)/, '')
    reg_url = Regexp.escape(url.to_s)
    contents.gsub!(/(#{reg_url}$|#{reg_url}[\W\/])/) { html.to_s }
  end

  def image
    image_urls.uniq.each do |url|
      host_name = URI.parse(url).hostname
      html = renderer.render partial: 'topics/image', locals: { url: url, host_name: host_name }
      convert_url_to_html!(url, html)
    end
  end

  def link_thumbnail_description(nofollow = false)
    link_urls.uniq.each do |url|
      site = LinkThumbnailer.generate(url)
      image_url = site.images.present? ?
        site.images.first.src.to_s : 'no_image.png'
      html = renderer.render partial: 'topics/link_thumbnail_description',
                             locals: { site: site, url: image_url , nofollow: nofollow}
      convert_url_to_html!(url, html)
    end
  end

  def sanitize_content
    sanitize(contents,
             tags: %w(a div img p br span),
             attributes: %w(alt id class href src target data-anchor rel))
  end

  def set_urls
    @image_urls, @link_urls = urls.partition do |url|
      url.match(/\.(jpg|jpeg|png|gif|bmp)/)
    end
  end
end
