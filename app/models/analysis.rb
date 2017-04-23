class Analysis < ApplicationRecord
  scope :yesterday_topic, -> { where(analysisable_type: 'Topic',
                                     date: Date.yesterday) }
end
