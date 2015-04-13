require 'rails_helper'
ActiveJob::Base.queue_adapter = :test

describe "adding new handles outside of posts", type: :feature do
  
  it "offers a new button" do
    visit handles_path
    expect(page).to have_selector(".button#new_handle")
  end

  it "shows the new form" do
    visit handles_path
    click_on "New"
    expect(page).to have_selector("form.new_handle")
  end

  it "creates a new handle" do
    visit handles_path
    click_on "New"
    fill_in "handle[name]", with: "@mytesthandle"
    click_on "Create Handle"
    handle = Handle.find_by(name: "@mytesthandle")
    expect(current_path).to eq handle_path(handle)
    # expect(current_path).to eq handles_path
    # expect(page).to have_selector("td.name", text: "@mytesthandle")
    expect(page).to have_selector("h1", text: "@mytesthandle")
  end

  describe "deleting handles" do
    before do
      @handle = FactoryGirl.create(:handle)
      @selector = "handle_#{@handle.id}"
    end

    pending "allows me to delete a handle", driver: :webkit do
      # @handle = FactoryGirl.create(:handle)
      handles = Handle.all
      visit handles_path
      # save_and_open_page
      expect(page).to have_selector(@selector)
      visit handle_path(@handle)
      # save_and_open_page
      accept_confirm do
        click_link('Delete')
      end
      visit handles_path
      expect(page).to_not have_selector(@selector)

    end
  end
end