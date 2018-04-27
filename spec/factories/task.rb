FactoryGirl.define do
  factory :task do
    caption "俺はテストを行う！"
    priority "S"
    state "着手待ち"
    deadline "2018-04-26"
  end
end
