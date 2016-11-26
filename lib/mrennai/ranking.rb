module Mrennai
  class Ranking
    MODEL_NAME = %w(Love)

    def self.update_read_count
      MODEL_NAME.each do |name|
        name.constantize.find_each do |klass|
          klass.update_read_count
        end
      end
    end

    def self.import_read
      date = DateTime.yesterday
      MODEL_NAME.each do |name|
        Read.import_data(name.constantize, date)
      end
    end
  end
end
