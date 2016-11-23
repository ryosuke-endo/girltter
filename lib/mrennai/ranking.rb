module Mrennai
  class Ranking
    MODEL_NAME = Love

    def self.update_read_count
      MODEL_NAME.find_each do |klass|
        klass.update_read_count
      end
    end
  end
end
