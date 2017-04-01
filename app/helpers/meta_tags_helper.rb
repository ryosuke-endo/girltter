module MetaTagsHelper
  def category_meta_tags(category)
    title = [category.name, t('site_title')]
    description = category.description
    keywords = [category.name]
    no_index_no_follow!

    set_meta_tags title: title,
                  description: description,
                  keywords: keywords
  end

  def top_meta_tags
    title = [t('site_title'), t("meta_tags.#{controller_name}.#{action_name}.title")]
    description = t("meta_tags.#{controller_name}.#{action_name}.description")
    keywords = t("meta_tags.#{controller_name}.#{action_name}.keywords")
    separator = '|'
    no_index_no_follow!

    set_meta_tags title: title,
                  separator: separator,
                  description: description,
                  keywords: keywords
  end

  def topic_meta_tags(topic)
    title = [topic.title, t('site_title')]
    description = topic.body
    no_index_no_follow!

    set_meta_tags title: title,
                  description: description
  end

  def no_index_no_follow!
    set_meta_tags noindex: true,
                  nofollow: true
  end
end
