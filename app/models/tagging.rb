class Tagging < ActsAsTaggableOn::Tagging
  scope :ranking_ids, lambda { |type, count|
    where(taggable_type: type)
      .group(:tag_id)
      .order('count(tag_id) desc')
      .limit(count)
      .pluck(:tag_id)
  }
end
