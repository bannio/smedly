require 'rails_helper'

describe "adding topics" do
  it "allows a user to create a topic" do
    visit new_topic_path
    fill_in "topic[name]", with: "First Report"
    click_on "Create Topic"
    visit topics_path
    @topic = Topic.find_by_name("First Report")
    expect(page).to have_selector("#topic_#{@topic.id} .name", text: "First Report")
  end
end