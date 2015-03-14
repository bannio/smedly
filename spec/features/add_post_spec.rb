require 'rails_helper'

describe "adding posts to topics" do

  let(:topic){ FactoryGirl.create(:topic) }

  it "allows a user to create add a post to topic" do
    visit topic_path(topic)
    click_on "Add post"
    fill_in "Content", with: "My first post"
    click_on "Save"
    post = Post.find_by_content("My first post")
    expect(page).to have_selector("#post_#{@post.id} .content", text: "My first post")
  end
end