require 'rails_helper'

describe "getting twitter details", vcr: {record: :once} do
  before do
    @handle = FactoryGirl.create(:handle, name: "@ocbannister", followers: 5)
  end

  it "updates the Twitter details" do
    visit handle_path(@handle)
    url = "https://pbs.twimg.com/profile_images/513038727199744001/B4Fhaytg_normal.jpeg"
    click_on "Refresh"
    expect(page).to have_selector("img[src='#{url}']")
    expect(page).to have_content("UK")
  end
end