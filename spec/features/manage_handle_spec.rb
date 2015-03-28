require 'rails_helper'

describe "managing handles" do

  before do
    @handle = FactoryGirl.create(:handle, name: "@test-handle")
  end

  it "can list handles" do
    visit handles_path
    expect(page).to have_selector("td.name", text: "@test-handle")
  end

  it "allows me to select a handle" do
    visit handles_path
    within("#handle_#{@handle.id}") do
      click_on "view"
    end
    expect(current_path).to eq handle_path(@handle)
  end

  it "shows me related tags" do
    @handle.tag_list.add("politics")
    @handle.save
    visit handles_path
    # visit handle_path(@handle)
    expect(page).to have_content("politics")
  end

  it "allows me to add tags" do
    visit handle_path(@handle)
    expect(page).to have_selector("input#handle_tag_list")
    # fill_in "handle[tag_list]", with: "economics"
    # click_on "Update Handle"
    # expect(page).to have_content("economics")
  end
end