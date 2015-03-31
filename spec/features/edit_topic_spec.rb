require 'rails_helper'

describe "editing a topic" do

  before do
    FactoryGirl.create(:platform, name: "None")
  end

  let(:topic){ FactoryGirl.create(:topic, name: "original name") }

  it "allows a user to edit a topic" do
    visit topic_path(topic)
    click_on "Edit Topic"
    fill_in "topic[name]", with: "Changed name"
    click_on "Update Topic"
    visit topics_path
    @topic = Topic.find_by_name("Changed name")
    expect(page).to have_selector("#topic_#{@topic.id} .name", text: "Changed name")
  end

  it "allows you to cancel" do
    visit topic_path(topic)
    click_on "Edit Topic"
    fill_in "topic[name]", with: "Changed name"
    click_on "Cancel"
    visit topics_path
    @topic = Topic.find_by_name("original name")
    expect(page).to have_selector("#topic_#{@topic.id} .name", text: "original name")
  end
end