class RedisService
  TERM = %w(daily)

  def self.count_up(id, name)
    key = new.key(name, Date.today)
    redis = new.redis
    redis.zincrby(key, 1, id)
    redis.expire(key, Constants::Redis::DAY_COUNTER_EXPIRES) unless redis.ttl(key)
  end

  def self.count(id, name, date)
    key = new.key(name, date)
    daily_ranking = new.daily_ranking(key)
    daily_ranking.assoc(id.to_s)&.last.to_i
  end

  def key(name, date)
    "#{TERM[0]}/#{name}/#{date}"
  end

  def redis
    Redis.current
  end

  def daily_ranking(key)
    redis.zrange(key, 0, -1, with_scores: true)
  end
end
