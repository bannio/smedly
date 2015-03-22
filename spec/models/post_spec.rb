require 'rails_helper'

RSpec.describe Post, type: :model do
  it "starts life as draft" do
    post = Post.new
    expect(post.draft?).to be_truthy
  end

  it "can extract handles from content strings" do
    tweet = "My test @my_handle tweet @another too"
    post = Post.new(content: tweet)
    expect(post.handles_in_post).to eq ["@my_handle", "@another"]
  end

  describe "CSV export" do
    let(:topic){ Topic.create(name: "Topic with posts") }
    let(:post){ Post.new(content: "Ready to extract", topic_id: topic.id,
      posted_on: 1.days.from_now.change(hour: 12, min: 05)) }
    it "generates a CSV file in Hootsuite format" do
      csv = post.to_csv
      expect(csv).to eq "#{1.days.from_now.change(hour: 12, min: 05)},'Ready to extract'"
    end
    it "sets the status to 'extracted'" do

    end
  end
end
