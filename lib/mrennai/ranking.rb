module Mrennai
  class Ranking
    MODEL_NAME = Love

    def self.update_read_count
      MODEL_NAME.find_each do |klass|
        klass.update_read_count
      end
    end

    def self.import_read
      date = DateTime.yesterday
      Read.import(MODEL_NAME, date)
    end
  end
end
