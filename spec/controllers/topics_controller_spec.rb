require 'rails_helper'

RSpec.describe TopicsController, type: :controller do
  describe "POST create" do
    it "creates a topic" do
      post :create, topic: {name: "Report"}
      expect(response).to redirect_to(topics_path)
      expect(assigns(:topic).name).to eq("Report")
    end
  end
end
