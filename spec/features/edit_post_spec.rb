require 'rails_helper'

describe "editing a post" do
  before do
    FactoryGirl.create(:platform, name: "None")
    @platform = FactoryGirl.create(:platform, name: "Twitter")
    @topic = FactoryGirl.create(:topic)
    @post = FactoryGirl.create(:post, topic: @topic, content: "original words", platform: @platform)
  end
  
  it "moves posts into the form for editing" do
    visit topic_path(@topic)
    within("#post_#{@post.id}") do
      click_on "Edit"
    end
    expect(page).to have_selector("#post_content", text: "original words")

  end
end