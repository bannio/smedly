require 'rails_helper'
ActiveJob::Base.queue_adapter = :test

describe "adding posts to topics" do

    let(:topic){ FactoryGirl.create(:topic) }
  before do
    FactoryGirl.create(:platform, name: "None")
    FactoryGirl.create(:platform, name: "Twitter")
  end

  it "allows a user to add a post to topic" do
    visit topic_path(topic)
    within "#post-form" do
      choose "Twitter"
    end
    # select "Twitter", from: "post[platform_id]"
    fill_in "post_content", with: "My first post"
    click_on "Create Post"
    post = Post.find_by_content("My first post")
    expect(page).to have_selector("#post_#{post.id} .content", text: "My first post")
  end

  it "shows handles used in the posts" do
    visit topic_path(topic)
    within "#post-form" do
      choose "Twitter"
    end
    # select "Twitter", from: "post[platform_id]"
    fill_in "post_content", with: "My first post with @first_handle"
    click_on "Create Post"
    post = Post.find_by_content("My first post with @first_handle")
    expect(page).to have_selector("#post_#{post.id} .content", text: "My first post")
    # save_and_open_page
    expect(page).to have_selector("div#handles", text: "@first_handle")
  end

  it "sets the default post date to the topic's publish date" do
    visit topic_path(topic)
    within "#post-form" do
      choose "Twitter"
    end
    # select "Twitter", from: "post[platform_id]"
    fill_in "post_content", with: "My first post"
    click_on "Create Post"
    post = Post.find_by_content("My first post")
    expect(post.posted_on).to eq Date.today.to_datetime.change(hour: 12, min: 05)
  end
end