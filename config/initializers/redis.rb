require 'redis'

uri = URI.parse(Rails.application.secrets[:redis])
namespace = [Rails.application.class.parent_name, Rails.env].join '::'
Redis.current = Redis::Namespace.new(namespace,
                                     redis: Redis.new(host: uri.host,
                                                      port: uri.port))
