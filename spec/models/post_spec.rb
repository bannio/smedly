require 'rails_helper'

RSpec.describe Post, type: :model do
  it "starts life as draft" do
    post = Post.new
    expect(post.draft?).to be_truthy
  end
end
