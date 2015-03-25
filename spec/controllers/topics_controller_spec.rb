require 'rails_helper'

RSpec.describe TopicsController, type: :controller do

  describe "GET index" do
    it "is a successful index request" do
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end
  end

  describe "GET show" do
    it "shows a topic" do
      topic = Topic.create!(name: "test")
      get :show, id: topic.id
      expect(response).to have_http_status(:success)
      expect(assigns(:topic).id).to eq(topic.id)
    end
  end

  describe "POST create" do
    it "creates a topic" do
      post :create, topic: {name: "Report"}
      expect(response).to redirect_to(topics_path)
      expect(assigns(:topic).name).to eq("Report")
    end

    it "goes back to new on failure" do
      post :create, topic: {name: ""}
      expect(response).to render_template(:new)
      expect(assigns(:topic)).to be_present
    end
  end

  describe "GET edit" do
    it "finds the right topic" do
      topic = Topic.create!(name: "test")
      get :edit, id: topic.id
      expect(assigns(:topic).id).to eq topic.id
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH update" do
    let(:topic) { Topic.create!(name: "test") }
    it "updates the topic" do
      patch :update, id: topic.id, topic: {name: "test updated"}
      expect(assigns(:topic).id).to eq topic.id
      expect(response).to redirect_to(topic_path(topic))
    end
    it "returns to edit on failure" do
      patch :update, id: topic.id, topic: {name: ""}
      expect(assigns(:topic).id).to eq topic.id
      expect(response).to render_template(:edit)
    end
  end
end