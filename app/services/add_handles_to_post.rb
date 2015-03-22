class AddHandlesToPost

  def initialize(post)
    @post = post
  end

  def build
    handles = @post.handles_in_post
    @post.handles.clear
    handles.each do |handle|
      @post.handles << Handle.find_or_create_by(name: handle)
    end
    @post
  end
end