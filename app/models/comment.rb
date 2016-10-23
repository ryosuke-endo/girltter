class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :member
  validates :body, presence: true
end
