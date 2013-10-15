require 'spec_helper'

describe TwitterWorker, sidekiq: :fake do

  it { should be_retryable false }

  it "should have 1 enqueued job" do
    TwitterWorker.perform_async("github")
    expect(TwitterWorker).to have_enqueued_jobs(1)
  end
end

