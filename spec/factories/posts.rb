FactoryGirl.define do
  factory :post do
    topic
    content "MyText"
    posted_on Date.today
    status 0
    platform
  end

end
