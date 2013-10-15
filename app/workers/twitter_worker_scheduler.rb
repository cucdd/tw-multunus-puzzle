class TwitterWorkerScheduler
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  sidekiq_options retry: 5

  recurrence { hourly(4) }

  def perform
    Person.redis='BUG' # bug in redic
    Person.all.each_with_index do |person, index|
      # Twitter API v1.1 has 15 minute rate limit window
      TwitterWorker.perform_in(15.minutes * index, person.name)
    end
  end
end
