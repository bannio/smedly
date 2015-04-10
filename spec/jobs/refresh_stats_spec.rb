require 'rails_helper'
ActiveJob::Base.queue_adapter = :test

describe RefreshStats do

  before do
    ActiveJob::Base.queue_adapter.enqueued_jobs = []
  end

  it "queues a job" do
    RefreshStats.perform_later
    # puts ActiveJob::Base.queue_adapter.enqueued_jobs
    expect(ActiveJob::Base.queue_adapter.enqueued_jobs.size).to eq 1
  end

  it "saves the handle" do
    handle = spy
    RefreshStats.new.perform(handle)
    expect(handle).to have_received(:save!)
  end

  it "calls the adapter" do
    handle = spy  # equivalent to double as_null_object
    RefreshStats.new.perform(handle)
    expect(handle).to have_received(:refresh_twitter_stats)
  end
end