class PostsController < ApplicationController

  # def new
  #   @topic = Topic.find(params[:topic_id])
  #   @post = @topic.posts.build
  # end

  def extract
    @topic = Topic.find(params[:topic])
    @posts = Post.final.where(platform_id: params[:platform][:id], topic_id: @topic.id)
    platform = Platform.find(params[:platform][:id]).name
    if @posts.empty?
      flash[:alert] = "No final posts found for #{platform}"
      redirect_to @topic
    else
      send_data Post.to_csv(@posts), filename: 'hoottweets.csv'
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
    params[:post][:url] = full_url(params[:post][:url])
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
    params[:post][:url] = full_url(params[:post][:url])
    @post = @topic.posts.build(post_params)
    @post = AddHandlesToPost.new(@post).build
    if @post.save
      redirect_to @topic
    else
      flash.now[:alert] = "#{@post.errors.full_messages.first}"
      render 'topics/show'
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :posted_on, :platform_id, :topic_id, :url, :status)
  end
end