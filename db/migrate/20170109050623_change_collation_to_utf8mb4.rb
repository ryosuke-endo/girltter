class ChangeCollationToUtf8mb4 < ActiveRecord::Migration

  def all_tables
    %w(
      categories
      comments
      loves
      rankings
      reads
      schema_migrations
      supplementals
      taggings
      tags
      topics
      users
    )
  end

  def up
    all_tables.each do |table|
      execute "ALTER TABLE `#{table}` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"
    end
  end

  def down
    all_tables.each do |table|
      execute "ALTER TABLE `#{table}` CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci"
    end
  end
end
