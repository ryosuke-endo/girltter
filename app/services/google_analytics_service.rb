require 'google/apis/analyticsreporting_v4'
require 'googleauth'

class GoogleAnalyticsService
  include Google::Apis::AnalyticsreportingV4
  include Google::Auth

  PATH = "#{Rails.root}/config/google-auth-cred.json"
  VIEW_ID = "147114068"
  SCOPE = 'https://www.googleapis.com/auth/analytics.readonly'

  def initialize
    @client = AnalyticsReportingService.new
    @client.authorization = creds
    @metric = Metric.new
    @dimension = Dimension.new
    @date_range = DateRange.new
  end

  def fetch_pageview(klass, start_date, end_date)
    type = klass.name
    path = klass.table_name
    filters_expression = "ga:pagePath=~^/#{path}/[0-9]*$"
    @metric.expression = "ga:pageviews"
    @dimension.name = "ga:pagePath"

    (start_date..end_date).each do |date|
      @date_range.start_date = date
      @date_range.end_date = date
      report = ReportRequest.new(view_id: VIEW_ID,
                                 metrics: [@metric],
                                 dimensions: [@dimension],
                                 date_ranges: [@date_range],
                                 filters_expression: filters_expression)
      request = GetReportsRequest.new(report_requests: [report])
      response = @client.batch_get_reports(request)
      reports = response.reports
      reports.first.data.rows.each do |row|
        row.dimensions.first.match(/([0-9]+$)/)
        analysisable_id = $1
        analysisable_type = type
        pageview = row.metrics.first.values.first.to_i
        Analysis.create(analysisable_id: analysisable_id,
                        analysisable_type: analysisable_type,
                        pageview: pageview,
                        date: date)
      end
    end
  end

  private

  def creds
    cred_path = File.open(PATH)
    ServiceAccountCredentials.make_creds(json_key_io: cred_path,
                                         scope:  SCOPE)
  end
end
