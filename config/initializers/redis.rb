$redis = Redis.new(:host => ENV['OPENSHIFT_REDIS_HOST'],
                   :port => ENV['OPENSHIFT_REDIS_PORT'],
                   :password => ENV['REDIS_PASSWORD'],
                   :db => 1
                  )

