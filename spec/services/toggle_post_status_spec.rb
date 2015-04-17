require 'rails_helper'

RSpec.describe TogglePostStatus, type: :service do

  it "changes draft to final" do
    post = FactoryGirl.build(:post, status: 0)
    expect(post).to receive(:final!)
    TogglePostStatus.new(post).toggle
  end

  it "changes final to posted" do
    post = FactoryGirl.build(:post, status: 1)
    expect(post).to receive(:posted!)
    TogglePostStatus.new(post).toggle
  end

  it "changes posted to draft" do
    post = FactoryGirl.build(:post, status: 2)
    expect(post).to receive(:draft!)
    TogglePostStatus.new(post).toggle
  end
end