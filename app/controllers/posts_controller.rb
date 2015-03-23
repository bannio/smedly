class PostsController < ApplicationController

  # def new
  #   @topic = Topic.find(params[:topic_id])
  #   @post = @topic.posts.build
  # end

  def index
    # temporary measure to test exports
    @posts = Post.final
    respond_to do |format|
      format.csv {
        send_data Post.to_csv(@posts), filename: 'hoottweets.csv' unless @posts.empty?
      }
    end
  end

  def edit
    @post = Post.find(params[:id])
    @topic = @post.topic
    render 'topics/show'
  end

  def update
    @topic = Topic.find(params[:post][:topic_id])
    @post = Post.find(params[:id])
    @post.update(post_params)
    @post = AddHandlesToPost.new(@post).build
    if @post.valid?
      redirect_to @topic
    else
      render 'topics/show'
    end
  end

  def create
    @topic = Topic.find(params[:post][:topic_id])
    @post = @topic.posts.build(post_params)
    @post = AddHandlesToPost.new(@post).build
    if @post.save
      redirect_to @topic
    else
      render 'topics/show'
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :posted_on, :platform_id, :topic_id, :url, :status)
  end
end
