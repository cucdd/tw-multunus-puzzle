require 'spec_helper'

describe TwitterWorkerScheduler, sidekiq: :fake do

  it { should be_retryable 5 }

  it "should have 1 enqueued job" do
    TwitterWorkerScheduler.perform_async
    expect(TwitterWorkerScheduler).to have_enqueued_jobs(1)
  end
end

