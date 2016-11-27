module Mrennai
  class BatchJob
    MODEL = %w(Love)

    def self.run
      yesterday = Date.yesterday
      import_read(MODEL, yesterday)
      update_ranking
      update_read_count(MODEL, yesterday)
    end

    def self.import_read(model, date)
      model.each do |name|
        Read.import_data(name.constantize, date)
      end
    end

    def self.update_ranking
      Ranking.yesterday_ranking
    end

    def self.update_read_count(model, date)
      model.each do |name|
        ActiveRecord::Base.transaction do
          name.constantize.find_each do |klass|
            klass.update_read_count!(date)
          end
        end
      end
    end
  end
end
