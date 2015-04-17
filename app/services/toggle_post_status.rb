class TogglePostStatus
  def initialize(post)
    @post = post
  end

  def toggle
    case @post.status
    when "draft"
      @post.final!
    when "final"
      @post.posted!
    else
      @post.draft!
    end
    @post
  end

end