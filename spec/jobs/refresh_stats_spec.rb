require 'rails_helper'
ActiveJob::Base.queue_adapter = :test

describe RefreshStats do
  
  it "queues a job" do
    RefreshStats.perform_later
    expect(ActiveJob::Base.queue_adapter.enqueued_jobs.size).to eq 1
  end

  it "saves the handle" do
    handle = spy
    RefreshStats.new.perform(handle)
    expect(handle).to have_received(:save!)
  end

  it "calls the adapter" do
    handle = spy
    RefreshStats.new.perform(handle)
    expect(handle).to have_received(:refresh_twitter_stats)
  end
end