class Supplemental < ActiveRecord::Base
  belongs_to :supplementable, polymorphic: true
  validates :body, presence: true
  validate :limit_supplementable

  def limit_supplementable
    if supplementable.supplementals.count >= 2
      errors.add(:body, I18n.t('errors.messages.max_matter', count: 2))
    end
  end
end
