FactoryGirl.define do
  factory :topic do
    name "Latest Report"
    summary "The latest test report"
    publish_date Date.today
    status 0
  end

end
