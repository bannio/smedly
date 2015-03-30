require 'rails_helper'

describe "adding new handles outside of posts" do
  
  it "offers a new button" do
    visit handles_path
    expect(page).to have_selector(".button#new_handle")
  end
end