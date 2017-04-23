class Analysis < ApplicationRecord
  scope :yesterday_topic_ranking, -> { where(analysisable_type: 'Topic',
                                             date: Date.yesterday).
                                       order(pageview: :desc) }

  belongs_to :analysisable, polymorphic: true
end
