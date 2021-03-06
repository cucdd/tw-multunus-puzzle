class Person < Ohm::Model
  attribute :name
  attribute :image

  unique :name
  index :name

  # bug in redic, accepts password and db in URI but
  # doesn't act on it, monkey patching
  # TODO: patc upstream
  def self.redis=(redis)
    @redis = Redic.new("redis://localhost:6379/")
  end

  # TODO: doesn't work , bug in Ohm ?
  def validate
    assert_present :name
    assert_url :image
  end
end
