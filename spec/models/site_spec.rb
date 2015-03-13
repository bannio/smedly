require 'rails_helper'

RSpec.describe Site, type: :model do
  it "requires a name" do
    site = Site.new(name: "")
    expect(site).to_not be_valid
  end
end
