FactoryGirl.define do
  factory :task do
    caption "俺はテストを行う！"
    priority_id 1
    status_id 1
    deadline "2018-04-26"
  end
end
