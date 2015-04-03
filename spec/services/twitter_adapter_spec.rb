require 'rails_helper'

describe TwitterAdapter do
  it "accurately receives profile image url", :vcr do
    handle = double(name: "@ocbannister")
    adapter = TwitterAdapter.new(handle)
    url = "http://pbs.twimg.com/profile_images/513038727199744001/B4Fhaytg_normal.jpeg"
    expect(adapter.profile_image_url).to eq url
  end
end
