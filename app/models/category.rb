class Category < ActiveRecord::Base
  class_attribute :cached_map

  has_attached_file :image, styles: { medium: '300x300>', thumb: '140x140>' }
  has_many :topics

  validates :name, presence: true
  validates :description, presence: true
  validates_attachment :image,
                       content_type: { content_type: ['image/jpg',
                                                      'image/jpeg',
                                                      'image/png',
                                                      'image/gif'] }

  scope :ordered_position, -> { order(position: :asc) }

  def self.cached
    fetch_cached_map
  end

  def self.find_cached(id)
    cached[id.to_i]
  end

  def self.fetch_cached_map
    if cached_map.blank?
      self.cached_map = order(:id).map { |x| [x.id, x] }.to_h
    else
      cached_map
    end
  end

  private_class_method :fetch_cached_map
end
