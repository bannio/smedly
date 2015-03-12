require 'rails_helper'

describe Report do
  it "starts life as open" do
    report = Report.new
    expect(report.open?).to be_truthy
  end
end