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

  def post_date_default
    # Hootsuite requires times to end in 0 or 5
    1.days.from_now.change(hour: 12, min: 05)
  end

  def formatted_handles(handles)
    # create a string from an array of handle names
    list = handles.join(" ")
  end

  def background_class(num)
    css = ""
    r = 94..116
    if r.include?(num)
      css = "amber-background"
    elsif num > 116
      css = "red-background"
    end
    css
  end
end
