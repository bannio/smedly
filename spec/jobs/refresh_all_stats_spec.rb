require 'rails_helper'
# require 'sucker_punch/testing/inline'
# require 'active_job/test_helper'
ActiveJob::Base.queue_adapter = :test

describe RefreshAllStats do

  before do
    ActiveJob::Base.queue_adapter.enqueued_jobs = []
  end

  it "queues a job" do
    RefreshAllStats.perform_later
    expect(ActiveJob::Base.queue_adapter.enqueued_jobs.size).to eq 1
  end

end