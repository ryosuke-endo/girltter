require 'google/apis/analyticsreporting_v4'
require 'googleauth'

class GoogleAnalyticsService
  include Google::Apis::AnalyticsreportingV4
  include Google::Auth

  PATH = "#{Rails.root}/config/google-auth-cred.json"
  VIEW_ID = "147114068"
  SCOPE = 'https://www.googleapis.com/auth/analytics.readonly'

  attr_reader :reports

  def initialize
    @client = AnalyticsReportingService.new
    @client.authorization = creds
    @metric = Metric.new
    @dimension = Dimension.new
    @date_range = DateRange.new
  end

  def report
    @metric.expression = "ga:pageviews"
    @dimension.name = "ga:pagePath"
    @date_range.start_date = Date.yesterday
    @date_range.end_date = Date.today
    report = ReportRequest.new(view_id: VIEW_ID,
                               metrics: [@metric],
                               dimensions: [@dimension],
                               date_ranges: [@date_range],
                               filters_expression: 'ga:pagePath=~^/topics\/\d*$')
    request = GetReportsRequest.new(
      report_requests: [report]
    )
    response = @client.batch_get_reports(request)
    @reports = response.reports
  end

  private

  def creds
    cred_path = File.open(PATH)
    ServiceAccountCredentials.make_creds(json_key_io: cred_path,
                                         scope:  SCOPE)
  end
end
