require "rails_helper"

describe "deleting posts", type: :feature, js: true do
  before do
    # @topic = FactoryGirl.create(:topic, name: "Test delete posts")
    @post = FactoryGirl.create(:post, content: "to be deleted")
  end

  it "allows me to delete a post" do
    visit topic_path(@post.topic)
    within "#post_#{@post.id}" do
      accept_confirm do
        click_link('Delete')
      end
      # click_link('Delete')
    end
    # page.driver.browser.switch_to.alert.accept
    visit topic_path(@topic)
    expect(page).to_not have_selector("#post_#{@post.id}")
  end
end