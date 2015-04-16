class TogglePostStatus
  def initialize(post)
    @post = post
  end

  def toggle
    return @post if @post.posted?
    @post.final? ? @post.draft! : @post.final!
    @post
  end

end