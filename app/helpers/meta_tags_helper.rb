module MetaTagsHelper
  def category_meta_tags(category)
    title = ["「#{category.name}」に関するトピック", t('site_title')]
    description = category.description
    keywords = [category.name]

    set_meta_tags title: title,
                  description: description,
                  keywords: keywords
  end

  def tags_meta_tags(tag)
    name = tag.name
    title = ["「#{name}」に関するトピック", t('site_title')]
    description =
    <<~"EOS"
    「#{name}」に関するトピックです。
    女性目線の本音で語られている「#{name}」の話題です。
    「#{name}」のおしゃべりに参加しよう！
    EOS
    keywords = [name]

    set_meta_tags title: title,
                  description: description,
                  keywords: keywords
  end

  def top_meta_tags
    title = [t('site_title'), t("meta_tags.#{controller_name}.#{action_name}.title")]
    description = t("meta_tags.#{controller_name}.#{action_name}.description")
    keywords = t("meta_tags.#{controller_name}.#{action_name}.keywords")
    separator = '|'

    set_meta_tags title: title,
                  separator: separator,
                  description: description,
                  keywords: keywords
  end

  def topic_meta_tags(topic)
    title = [topic.title, t('site_title')]
    description = topic.body

    set_meta_tags title: title,
                  description: description
  end
end
