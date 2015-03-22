module TopicsHelper

  def topic_date_format(date)
    date.strftime("%A #{date.day.ordinalize} %B %Y")
  end

  def post_date_format(date)
    date.strftime("%a %e %B %Y at %H:%M")
  end

  def post_date_default
    # Hootsuite requires times to end in 0 or 5
    1.days.from_now.change(hour: 12, min: 05)
  end

  def formatted_handles(handles)
    # create a string from an array of handle names
    list = handles.join(" ")
  end
end
