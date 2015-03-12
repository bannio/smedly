require 'rails_helper'

describe Report do
  it "starts life as active" do
    report = Report.new
    expect(report.active?).to be_truthy
  end
end