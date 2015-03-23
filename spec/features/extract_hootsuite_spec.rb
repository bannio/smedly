require 'rails_helper'

describe "Extracting files for Hootsuite" do

  before do
    @gis = FactoryGirl.create(:platform, name: "Twitter-GIS")
    @wr = FactoryGirl.create(:platform, name: "Twitter-WR")
    @topic = FactoryGirl.create(:topic)
    @draft_post = FactoryGirl.create(:post, platform_id: @gis.id, content: "draft post")
    @gis_final_post = FactoryGirl.create(:post, platform_id: @gis.id, content: "final post", status: Post.statuses[:final])
    @wr_final_post = FactoryGirl.create(:post, platform_id: @wr.id, content: "final post", status: Post.statuses[:final])
  end
  
  it "allows you to choose the platform" do
    visit topic_path(@topic)
    choose "Twitter-GIS"
    # click_on 'Extract for Hootsuite'
    # click_on "Create extract"
    expect(page).to have_selector("#handles")
    
  end

  it "only selects posts for the chosen platform" do
    
  end

  it "selects only final posts" do
    
  end


end