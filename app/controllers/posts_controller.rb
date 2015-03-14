class PostsController < ApplicationController

  # def new
  #   @topic = Topic.find(params[:topic_id])
  #   @post = @topic.posts.build
  # end

  def create
    @topic = Topic.find(params[:post][:topic_id])
    @post = @topic.posts.build(post_params)
    if @post.save
      redirect_to @topic
    else
      render 'topics/show'
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :posted_on, :platform_id, :topic_id)
  end
end
