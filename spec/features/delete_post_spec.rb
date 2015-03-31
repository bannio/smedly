require "rails_helper"

describe "deleting posts", type: :feature, js: true do
  before do
    FactoryGirl.create(:platform, name: "None")
    @topic = FactoryGirl.create(:topic, name: "Test delete posts")
    @post = FactoryGirl.create(:post, topic_id: @topic.id, content: "to be deleted")
  end

  it "allows me to delete a post", driver: :webkit do
    visit topic_path(@topic)
    # save_and_open_page
    @selector = "post_#{@post.id}"

    within "#post_#{@post.id}" do
      accept_confirm do
        click_link('Delete')
      end
    end
    visit topic_path(@topic)
    # save_and_open_page
    expect(page).to_not have_selector(@selector)
  end
end