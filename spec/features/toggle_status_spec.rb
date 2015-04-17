require 'rails_helper'

describe "toggling status of posts", type: :feature, js: true, driver: :webkit do

  before do
    FactoryGirl.create(:platform, name: "None")
    @platform = FactoryGirl.create(:platform, name: "Twitter")
    @topic = FactoryGirl.create(:topic)
  end

  it "allows change from draft to final" do
    @draft_post = FactoryGirl.create(:post, topic: @topic, content: "draft post", platform: @platform, status: 0)
    visit topic_path(@topic)
    click_on "draft"
    expect(page).to have_selector("td.final")
  end

  it "allows change from final to posted" do
    @final_post = FactoryGirl.create(:post, topic: @topic, content: "final post", platform: @platform, status: 1)
    visit topic_path(@topic)
    click_on "final"
    expect(page).to have_selector("td.posted")
  end

  it "allows change from posted to draft" do
    @posted_post = FactoryGirl.create(:post, topic: @topic, content: "posted post", platform: @platform, status: 2)
    visit topic_path(@topic)
    click_on "posted"
    expect(page).to have_selector("td.draft")
  end
end