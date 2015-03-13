require 'rails_helper'

describe "adding topics" do
  it "allows a user to create a topic" do
    visit new_topic_path
    fill_in "Name", with: "First Report"
    click_on "Create Topic"
    visit_topics_path
    expect(page).to have_content("First Report")
  end
end