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
    before do
      post = FactoryGirl.create(:post, content: 'Ready to extract http://test@example.com/',
      posted_on: 1.days.from_now.change(hour: 12, min: 05))
    end

    it "generates a CSV file in Hootsuite format" do
      posts = Post.all
      csv = Post.to_csv(posts)
      expect(csv).to eq "#{1.days.from_now.change(hour: 12, min: 05).strftime("%m/%d/%y %H:%M")},Ready to extract\n"
    end
    it "sets the status to 'extracted'" do

    end
  end
end
