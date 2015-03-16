require 'rails_helper'

RSpec.describe Platform, type: :model do
  
  it "default scope alphabetical order" do
    FactoryGirl.create(:platform, name: "B")
    FactoryGirl.create(:platform, name: "C")
    FactoryGirl.create(:platform, name: "A")

    expect(Platform.all.map(&:name)).to eq(%w{A B C})
    
  end
end
