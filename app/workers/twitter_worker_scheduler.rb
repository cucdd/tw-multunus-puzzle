class TwitterWorkerScheduler
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  sidekiq_options retry: 5

  recurrence { hourly(5) }

  def perform
    Person.redis='BUG' # bug in redic
    Person.all.each_with_index do |person, index|
      # Twitter API v1.1 has 15 minute rate limit window
      # Each user will take 2-3 minutes to finish
      TwitterWorker.perform_in(20.minutes * index, person.name)
    end
  end
end
