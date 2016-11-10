class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :member

  validates :body, presence: true

  accepts_nested_attributes_for :commentable

  scope :answer_ids, -> { pluck(:commentable_id).uniq }
end
