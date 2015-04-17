require 'rails_helper'

RSpec.describe TopicsController, type: :controller do

  describe "GET index" do
    it "is a successful index request" do
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end

    it "retrieves in descending publish date order" do
      topic_last = FactoryGirl.create(:topic, publish_date: 3.days.from_now, name: "second")
      topic_first = FactoryGirl.create(:topic, publish_date: 2.days.from_now, name: "first")
      get :index
      expect(assigns(:topics).to_a).to eq [topic_last, topic_first]
    end
  end

  describe "GET show" do
    it "shows a topic" do
      topic = Topic.create!(name: "test", publish_date: Date.today)
      get :show, id: topic.id
      expect(response).to have_http_status(:success)
      expect(assigns(:topic).id).to eq(topic.id)
    end
  end

  describe "POST create" do
    it "creates a topic" do
      post :create, topic: {name: "Report", publish_date: Date.today}
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
      topic = Topic.create!(name: "test", publish_date: Date.today)
      get :edit, id: topic.id
      expect(assigns(:topic).id).to eq topic.id
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH update" do
    let(:topic) { Topic.create!(name: "test", publish_date: Date.today) }
    it "updates the topic" do
      patch :update, id: topic.id, topic: {name: "test updated"}
      expect(assigns(:topic).id).to eq topic.id
      expect(response).to redirect_to(topic_path(topic))
    end
    it "returns to edit on failure" do
      patch :update, id: topic.id, topic: {name: "", publish_date: Date.today}
      expect(assigns(:topic).id).to eq topic.id
      expect(response).to render_template(:edit)
    end
  end
end
