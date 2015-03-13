require 'rails_helper'

describe Topic, type: :model do
  it "starts life as active" do
    topic = Topic.new
    expect(topic.active?).to be_truthy
  end
  it "must always have a name" do
    topic = Topic.new(name: "")
    expect(topic).to_not be_valid
  end
  it "belongs to a site" do
    topic = Topic.new
    site = double(Site)
  end
end