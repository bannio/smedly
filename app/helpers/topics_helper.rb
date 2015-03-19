module TopicsHelper

  def topic_date_format(date)
    date.strftime("%A #{date.day.ordinalize} %B %Y")
  end

  def post_date_format(date)
    date.strftime("%a #{date.day.ordinalize} %B %Y at %H:%M")
  end
end
