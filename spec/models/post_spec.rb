require 'rails_helper'

RSpec.describe Post, type: :model do
  it "starts life as draft" do
    post = Post.new
    expect(post.draft?).to be_truthy
  end

  it "requires a content" do
    post = Post.new(content: "")
    post.valid?
    expect(post.errors[:content]).to eq ["can't be blank"]
  end

  it "can extract handles from content strings" do
    tweet = "My test @my_handle tweet @another too"
    post = Post.new(content: tweet)
    expect(post.handles_in_post).to eq ["@my_handle", "@another"]
  end

  it "can set the status to posted" do
    tweet = "My test @my_handle tweet @another too"
    post = Post.new(content: tweet)
    post.set_status_to_posted
    expect(post).to be_posted
  end

  it "can set the status to final" do
    tweet = "My test @my_handle tweet @another too"
    post = Post.new(content: tweet)
    post.set_status_to_final
    expect(post).to be_final
  end

  describe "CSV export" do
    before do
      @post = FactoryGirl.create(:post, content: "Ready to extract",
        url: "http://test.example.com/",
        posted_on: 1.days.from_now.change(hour: 12, min: 05))
    end

    it "generates a CSV file in Hootsuite format" do
      # mm/dd/yyyy hh:mm, message, url
      posts = Post.all
      csv = Post.to_csv(posts)
      expect(csv).to eq "#{1.days.from_now.change(hour: 12, min: 05).
        strftime("%m/%d/%Y %H:%M")},Ready to extract,http://test.example.com/\n"
    end

  end
end
