class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :member
  validates :body, presence: true

  scope :answer_ids, -> { pluck(:commentable_id).uniq }
end
