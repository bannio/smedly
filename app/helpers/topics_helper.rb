module TopicsHelper

  def topic_date_format(date)
    date.strftime("%A #{date.day.ordinalize} %B %Y")
  end

  def post_date_format(date)
    # date.strftime("%d %m %y at %H:%M")
    date.strftime("%H:%M on %d %m %y")
  end

  def post_day_format(date)
    # date.strftime("%d %m %y at %H:%M")
    date.strftime("%d/%m/%y")
  end

  def post_time_format(date)
    # date.strftime("%d %m %y at %H:%M")
    date.strftime("%H:%M")
  end

  def post_date_default(date)
    # Hootsuite requires times to end in 0 or 5
    date.to_datetime.change(hour: 12, min: 05)
  end

  def content_length(post)
    if post.content
      post.content.length
    else
      0
    end
  end

  def count_colour(post)
    count = post.content.length if post.content
    return "black" unless count
    if count >= 116
      "red"
    elsif count >= 94
      "orange"
    else
      "black"
    end
  end

  # def formatted_handles(handles)
  #   create a string from an array of handle names
  #   list = handles.join(" ")
  # end

  def count_background(num)
    css = ""
    r = 94..116
    if r.include?(num)
      css = "amber-background"
    elsif num > 116
      css = "red-background"
    end
    css
  end

  def platform_background(post)
    if post.platform
      post.platform.name.downcase.gsub(" ","")
    else
      "no-platform"
    end
  end

  def default_platform
    @default_platform ||= Platform.find_by(name: "None").id
  end
end
