class Comment < ActiveRecord::Base
  belongs_to :topic

  validates :body, presence: true
  validates :name, presence: true
end
