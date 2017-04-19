module MetaTagsHelper
  def default_meta_tags(opts = {})
    title = opts[:title] || [t("meta_tags.#{controller_name}.#{action_name}.title"), t('site_name')]
    description = opts[:description] || t("meta_tags.#{controller_name}.#{action_name}.description")
    keywords = opts[:keywords] || t("meta_tags.#{controller_name}.#{action_name}.keywords")
    icon = opts[:icon] || '/favicon.ico'
    type = opts[:type] || 'article'
    url = opts[:url] || request.original_url
    image = opts[:image_url] || image_url('og.png')

    configs = {
      title: title,
      description: description,
      keywords: keywords,
      reverse: opts[:reverse],
      icon: icon,
      og: {
        title: title.join(' | '),
        site_name: t('site_name'),
        description: description,
        type: type,
        url: url,
        image: image
      },
      twitter: {
        card: 'summary_large_image',
        site: '@girltter_',
        title: title.join(' | '),
        description: description,
        image: image
      }
    }

    set_meta_tags(configs)
  end

  def category_meta_tags(category)
    opts = {
      title: ["「#{category.name}」に関するトピック", t('site_name')],
      description: category.description,
      keywords: [category.name]
    }
    default_meta_tags(opts)
  end

  def tags_meta_tags(tag)
    name = tag.name
    title = ["「#{name}」に関するトピック", t('site_name')]
    description =
    <<~"EOS"
    「#{name}」に関するトピックです。
    女性目線の本音で語られている「#{name}」の話題です。
    「#{name}」のおしゃべりに参加しよう！
    EOS
    keywords = [name]

    opts = {
      title: title,
      description: description,
      keywords: keywords
    }
    default_meta_tags(opts)
  end

  def topic_meta_tags(topic)
    opts = {
      title: [topic.title, t('site_name')],
      description: topic.body
    }

    default_meta_tags(opts)
  end
end
