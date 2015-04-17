require 'rails_helper'
ActiveJob::Base.queue_adapter = :test

def attrs
  {
    name: "my name",
    publish_date: Date.today
  }
end

describe Topic, type: :model do
  it "starts life as active" do
    topic = Topic.new
    expect(topic.active?).to be_truthy
  end
  it "must always have a name" do
    topic = Topic.new(attrs.merge(name: ""))
    expect(topic).to_not be_valid
    expect(topic.errors[:name]).to eq ["can't be blank"]
  end
  it "must always have a date" do
    topic = Topic.new(attrs.merge(publish_date: ""))
    expect(topic).to_not be_valid
    expect(topic.errors[:publish_date]).to eq ["can't be blank"]
  end
  it "can find its handles" do
    topic = Topic.create(attrs)
    post = topic.posts.create(content: "post with @author and @editor handles")
    post.handles.create(name: "@author")
    post.handles.create(name: "@editor")
    expect(topic.handles.map(&:name)).to eq ["@author", "@editor"]
  end
end