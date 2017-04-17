# Set the host name for URL creation
bucket_name = Rails.application.secrets.bucket_name
host_name = Rails.application.secrets.s3_host_name
region = Rails.application.secrets.s3_region
aws_access_key_id = Rails.application.secrets.s3_access_key_id
aws_secret_access_key = Rails.application.secrets.s3_secret_access_key

SitemapGenerator::Sitemap.default_host = 'http://girltter.com'
SitemapGenerator::Sitemap.sitemaps_host = "http://#{host_name}/#{bucket_name}"
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

options = {
  aws_region: region,
  aws_access_key_id: aws_access_key_id,
  aws_secret_access_key: aws_secret_access_key
}

SitemapGenerator::Sitemap.adapter = SitemapGenerator::AwsSdkAdapter.new(bucket_name,
                                                                        options)

SitemapGenerator::Sitemap.create do
  Topic.find_each do |topic|
    add topic_path(topic), lastmod: topic.updated_at
  end
  ActsAsTaggableOn::Tag.where("taggings_count > 0").find_each do |tag|
    add tags_path(name: tag.name)
  end
  Category.find_each do |category|
    add category_path(category)
  end
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
end
