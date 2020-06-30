#REDIS = Redis.new(url: ENV['REDIS_URL'])

REDIS = Redis.new(url: 'redis://127.0.0.1:6379/0')