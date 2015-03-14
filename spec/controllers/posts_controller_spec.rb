require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "GET new" do
    it "renders new and assigns a post" do
      get :new
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
      expect(assigns(:post)).to be_an_instance_of(Post)
    end
  end

  describe "POST create" do
    let(:topic) { FactoryGirl.create(:topic) }
    it "creates a post and redirects to parent topic" do
      post :create, post: {content: "some content", topic_id: topic.id}
      expect(response).to redirect_to(topic_path(topic))
      expect(assigns(:post).content).to eq("some content")
    end

    it "goes back to new on failure" do
      post :create, post: {content: "missing topic id"}
      expect(response).to render_template(:new)
      expect(assigns(:post)).to be_present
    end
  end
end
