module Mrennai
  class Ranking
    MODEL = %w(Love)

    def self.run
      yesterday = Date.yesterday
      update_read_count(MODEL, yesterday)
      import_read(MODEL, yesterday)
    end

    def self.update_read_count(model, date)
      model.each do |name|
        name.constantize.find_each do |klass|
          klass.update_read_count(date)
        end
      end
    end

    def self.import_read(model, date)
      model.each do |name|
        Read.import_data(name.constantize, date)
      end
    end
  end
end
