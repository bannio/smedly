require 'rails_helper'

RSpec.describe AddHandlesToPost, type: :service do

  it "creates handles given a new post" do
    post = Post.new(content: "Test post with @name in it")
    creator = AddHandlesToPost.new(post).build
    expect(creator.handles.first.name).to eq("@name")
  end

  it "updates handles given an existing post, leaving existing handles in place" do
    post = FactoryGirl.create(:post, content: "a post with @first_handle in it")
    post = AddHandlesToPost.new(post).build # add the first handle
    post.save
    post.content = "a post which now has @last_handle in it"
    post = AddHandlesToPost.new(post).build
    post.save
    expect(post.reload.handles.count).to eq 1
    expect(post.handles.first.name).to eq "@last_handle"
    expect(Handle.find_by(name: "@first_handle")).to be
  end

  it "adds to existing handles" do
    post = FactoryGirl.create(:post, content: "a post with @first_handle in it")
    post = AddHandlesToPost.new(post).build # add the first handle
    post.save
    post.content = "a post which now has @first_handle and @last_handle in it"
    post = AddHandlesToPost.new(post).build
    post.save
    expect(post.reload.handles.count).to eq 2
    expect(post.handles.map(&:name)).to eq ["@first_handle", "@last_handle"]
    expect(Handle.find_by(name: "@first_handle")).to be
    expect(Handle.find_by(name: "@last_handle")).to be
  end
end