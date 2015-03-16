require 'rails_helper'

describe "adding posts to topics" do

    let(:topic){ FactoryGirl.create(:topic) }
  before do
    FactoryGirl.create(:platform, name: "Twitter")
  end

  it "allows a user to add a post to topic" do
    visit topic_path(topic)
    select "Twitter", from: "post[platform_id]"
    fill_in "Content", with: "My first post"
    click_on "Add post"
    post = Post.find_by_content("My first post")
    expect(page).to have_selector("#post_#{post.id} .content", text: "My first post")
  end
end