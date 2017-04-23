module Girltter
  class BatchJob
    def self.run
      update_analysis
    end

    def self.update_analysis
      analytics_service = GoogleAnalyticsService.new
      start_date = Date.yesterday
      end_date = Date.yesterday
      analytics_service.fetch_pageview(Topic, start_date, end_date)
    end
  end
end
