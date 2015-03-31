require 'rails_helper'

describe "Extracting files for Hootsuite" do

  before do
    FactoryGirl.create(:platform, name: "None")
    @gis = FactoryGirl.create(:platform, name: "Twitter-GIS")
    @wr = FactoryGirl.create(:platform, name: "Twitter-WR")
    @li = FactoryGirl.create(:platform, name: "LinkedIn")
    @topic = FactoryGirl.create(:topic)
    @draft_post = FactoryGirl.create(:post, platform_id: @gis.id,
      content: "draft post", topic_id: @topic.id)
    @gis_final_post = FactoryGirl.create(:post, platform_id: @gis.id,
      content: "final post", status: Post.statuses[:final], topic_id: @topic.id)
    @wr_final_post = FactoryGirl.create(:post, platform_id: @wr.id,
      content: "final post", status: Post.statuses[:final], topic_id: @topic.id)
  end

  it "allows you to choose the platform" do
    visit topic_path(@topic)
    within "#hootsuite-radio-set" do
      choose "Twitter-GIS"
    end
    click_on "Extract for Hootsuite"
    expect(page).to_not have_selector(".flash_alert", text: "No final posts found for Twitter-GIS")
  end

  it "only selects posts for the chosen platform" do
    visit topic_path(@topic)
    within "#hootsuite-radio-set" do
      choose "LinkedIn"
    end
    click_on "Extract for Hootsuite"
    expect(page).to have_selector(".flash_alert", text: "No final posts found for LinkedIn")
  end

  it "selects only final posts" do

  end


end