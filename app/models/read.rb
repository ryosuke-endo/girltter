class Read < ActiveRecord::Base
  belongs_to :readable, polymorphic: true

  validates :read_count, presence: true,
                         numericality: { only_integer: true }

  def self.import(klass, date)
    klass.find_each do |x|
      count = RedisService.count(x.id, name, date)
      create(readable_id: x.id,
             readable_type: x.class.name,
             read_count: count,
             recording_date: date)
    end
  end
end
