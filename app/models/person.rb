class Person < Ohm::Model
  attribute :name
  attribute :image

  unique :name
  index :name

  # bug in redic, accepts password and db in URI but
  # doesn't act on it, monkey patching
  # TODO: patch upstream
  def self.redis=(redis)
    host = ENV['OPENSHIFT_REDIS_HOST']
    port = ENV['OPENSHIFT_REDIS_PORT']
    # need to confirm this later - parse bug in URI.parse -> https://www.ruby-forum.com/topic/171362
    @redis = Redic.new("redis://#{host}:#{port}/")
    @redis.call('AUTH', ENV['REDIS_PASSWORD'])
  end

  # TODO: doesn't work , bug in Ohm ?
  def validate
    assert_present :name
    assert_url :image
  end
end
