require 'rails_helper'

RSpec.describe TogglePostStatus, type: :service do

  it "changes draft to final" do
    post = FactoryGirl.build(:post, status: 0)
    TogglePostStatus.new(post).toggle
    expect(post.final?).to be_truthy
  end

  it "changes final to draft" do
    post = FactoryGirl.build(:post, status: 1)
    TogglePostStatus.new(post).toggle
    expect(post.draft?).to be_truthy
    expect(post.final?).to be_falsey
  end

  it "ignores posted" do
    post = FactoryGirl.build(:post, status: 2)
    TogglePostStatus.new(post).toggle
    expect(post.final?).to be_falsey
    expect(post.posted?).to be_truthy
  end
end