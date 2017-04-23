class Analysis < ApplicationRecord
  scope :topic_ranking, ->(date) { where(analysisable_type: 'Topic',
                                         date: date).
                                         order(pageview: :desc) }

  belongs_to :analysisable, polymorphic: true
end
