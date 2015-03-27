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
    visit handle_path(@handle)
    expect(page).to have_selector("h3", text: "Tags")
    expect(page).to have_content("politics")
  end

  it "allows me to add tags" do
    visit handle_path(@handle)
    click_on "Add"
    fill_in "handle[tag]", with: "economics"
    click_on "Save"
    expect(page).to have_content("economics")
  end
end