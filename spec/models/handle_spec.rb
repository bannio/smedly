require 'rails_helper'

ActiveJob::Base.queue_adapter = :test

RSpec.describe Handle, type: :model do

  let(:fake_adapter){ instance_double(TwitterAdapter) }
  let(:handle){ Handle.new(name: "@test")}

  it "knows how to refresh its Twitter stats" do
    allow(TwitterAdapter).to receive(:new).with(handle).and_return(fake_adapter)
    allow(fake_adapter).to receive(:profile_image_url).and_return("fake_url")
    allow(fake_adapter).to receive(:location).and_return("UK")
    allow(fake_adapter).to receive(:followers).and_return(10)
    allow(fake_adapter).to receive(:tweets_count).and_return(8)
    allow(fake_adapter).to receive(:last_tweet_date).and_return(2.days.ago)
    allow(fake_adapter).to receive(:profile_description).and_return("Test twitter user")
    handle.refresh_twitter_stats
    expect(fake_adapter).to have_received(:profile_image_url)
    expect(fake_adapter).to have_received(:profile_description)
    expect(fake_adapter).to have_received(:tweets_count)
    expect(fake_adapter).to have_received(:last_tweet_date)
    expect(fake_adapter).to have_received(:followers)
    expect(fake_adapter).to have_received(:location)
    expect(TwitterAdapter).to have_received(:new)
  end

  it "requires a unique name" do
    handle1 = Handle.create(name: "@test")
    handle2 = Handle.new(name: "@test")

    expect(handle2).not_to be_valid
  end

  it "queues a job to update twitter stats after create" do
    ActiveJob::Base.queue_adapter.enqueued_jobs = []
    handle.save
    expect(ActiveJob::Base.queue_adapter.enqueued_jobs.size).to eq 1
  end
end