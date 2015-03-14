require 'rails_helper'

describe "editing a topic" do

  let(:topic){ FactoryGirl.create(:topic) }

  it "allows a user to edit a topic" do
    visit topic_path(topic)
    click_on "Edit"
    fill_in "Name", with: "Changed name"
    click_on "Save"
    visit topics_path
    @topic = Topic.find_by_name("Changed name")
    expect(page).to have_selector("#topic_#{@topic.id} .name", text: "Changed name")
  end
end