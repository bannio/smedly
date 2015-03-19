require 'rails_helper'

RSpec.describe CreatePost, type: :service do
  
  it "creates handles given a new post" do
    post = Post.new(content: "Test post with @name in it")
    creator = CreatePost.new(post)
    creator.build
    expect(creator.handles.first.name).to eq("@name")
  end
end