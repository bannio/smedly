module TopicsHelper

  def topic_date_format(date)
    date.strftime("%A #{date.day.ordinalize} %B %Y")
  end

  def post_date_format(date)
    date.strftime("%a %e %B %Y at %H:%M")
  end

  def post_date_default
    1.days.from_now.change(hour: 12, min: 03)
  end
end
