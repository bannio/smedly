require 'rails_helper'

describe "toggling status of posts", type: :feature, js: true, driver: :webkit do

  before do
    FactoryGirl.create(:platform, name: "None")
    @platform = FactoryGirl.create(:platform, name: "Twitter")
    @topic = FactoryGirl.create(:topic)
    @draft_post = FactoryGirl.create(:post, topic: @topic, content: "draft post", platform: @platform, status: 0)
    @final_post = FactoryGirl.create(:post, topic: @topic, content: "final post", platform: @platform, status: 1)
    @posted_post = FactoryGirl.create(:post, topic: @topic, content: "posted post", platform: @platform, status: 2)
  end
  
  it "allows change from draft to final" do
    visit topic_path(@topic)
    click_on "draft"
    expect(page).to have_xpath("//tr[@id='post_1']/td[@class='final'")
  end

  it "allows change from final to draft" do
    visit topic_path(@topic)
    click_on "final"
    expect(page).to have_selector("td.draft")
  end

  it "ignores posted status" do
    visit topic_path(@topic)
    click_on "draft"
    expect(page).to have_selector("td.posted")
  end
end