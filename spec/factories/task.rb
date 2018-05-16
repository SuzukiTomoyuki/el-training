FactoryGirl.define do
  factory :task do
    caption "俺はテストを行う！"
    priority 1
    status 1
    deadline "2018-04-26"
  end
end
