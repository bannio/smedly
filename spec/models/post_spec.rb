require 'rails_helper'

RSpec.describe Post, type: :model do
  it "starts life as draft" do
    post = Post.new
    expect(post.draft?).to be_truthy
  end

  it "can extract handles from content strings" do
    tweet = "My test @my_handle tweet @another too"
    post = Post.new(content: tweet)
    expect(post.handles_in).to eq ["@my_handle", "@another"]
  end
end
