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
  it "can find its handles" do
    topic = Topic.create(name: "Topic with handle")
    post = topic.posts.create(content: "post with @author and @editor handles")
    post.handles.create(name: "@author")
    post.handles.create(name: "@editor")
    expect(topic.handles.map(&:name)).to eq ["@author", "@editor"]
  end
end