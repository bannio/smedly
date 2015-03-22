require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  # describe "GET new" do
  #   it "renders new and assigns a post" do
  #     get :new
  #     expect(response).to have_http_status(:success)
  #     expect(response).to render_template(:new)
  #     expect(assigns(:post)).to be_an_instance_of(Post)
  #   end
  # end
  let(:topic) { FactoryGirl.create(:topic) }

  describe "POST create" do

    it "creates a post and redirects to parent topic" do
      post :create, post: {content: "some content", topic_id: topic.id}
      expect(response).to redirect_to(topic_path(topic))
      expect(assigns(:post).content).to eq("some content")
    end

    it "goes back to topic on failure" do
      post :create, post: {content: "", topic_id: topic.id}
      # allow_any_instance_of(Post).to receive(:save).and_return(false)
      expect(response).to render_template('topics/show')
      expect(assigns(:post)).to be_present
    end
  end

  describe "GET edit" do
    let(:post) { FactoryGirl.create(:post, topic: topic) }
    it "renders the post in the form on the show page" do
      get :edit, id: post.id
      expect(response).to have_http_status(:success)
      expect(response).to render_template('topics/show')
    end
  end

  describe "PATCH update" do
    let(:post) { FactoryGirl.create(:post, topic: topic) }

    it "redirects to @topic" do
      allow(AddHandlesToPost).to receive_message_chain(:new, :build).and_return(post)
      patch :update, id: post.id, post: {content: "test update", topic_id: topic.id}
      expect(response).to redirect_to(topic)
    end

    it "calls AddHandlersToPost" do
      allow(AddHandlesToPost).to receive_message_chain(:new, :build).and_return(post)
      expect(AddHandlesToPost).to receive(:new)
      patch :update, id: post.id, post: {content: "test update", topic_id: topic.id}
    end

    it "renders topic on failure" do
      allow(AddHandlesToPost).to receive_message_chain(:new, :build).and_return(post)
      allow(post).to receive(:valid?).and_return(false)
      patch :update, id: post.id, post: {content: "", topic_id: topic.id}
      # expect(assigns(:post)).to_not be_valid
      expect(response).to render_template('topics/show')
    end
  end
end
