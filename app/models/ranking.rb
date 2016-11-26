class Ranking < ActiveRecord::Base
  CALCULATING_COUNT = 10

  belongs_to :rankable, polymorphic: true

  validates :read_count, presence: true,
                         numericality: { only_integer: true }

  def self.yesterday_ranking
    date = DateTime.yesterday
    top_ranking = calculate_ranking(CALCULATING_COUNT, date)
    top_ranking.each do |r|
      create(rankable_id: r.readable_id,
             rankable_type: r.readable_type,
             read_count: r.read_count,
             start_date: r.recording_date)
    end
  end

  def self.calculate_ranking(count, date)
    'Read'.constantize.where(recording_date: date).
      order(read_count: :desc).
      limit(count)
  end
end
